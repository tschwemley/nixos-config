{ lib, pkgs, ... }:
let
  inherit (lib)
    isAttrs
    isBool
    isList
    ;

  inherit (lib.types)
    attrsOf
    bool
    coercedTo
    listOf
    nullOr
    number
    oneOf
    path
    str
    submodule
    ;
in
{
  # The KDL document language (https://kdl.dev/)
  # kdl =
  # {
  #   version,
  # }:
  # assert version == 1 || version == 2;
  format =
    {
      version ? 2,
    }:
    assert version == 1 || version == 2;
    {
      type = (
        let
          mergeUniq =
            mergeOne:
            lib.mergeUniqueOption {
              message = "";
              merge =
                loc: defs:
                let
                  inherit (lib.head defs) file value;
                in
                mergeOne file loc value;
            };

          mergeFlat =
            elemType: loc: file: value:
            if value ? _type then
              throw "${lib.showOption loc} has wrong type: expected '${elemType.description}', got `${value._type}`"
            else
              elemType.merge loc [ { inherit file value; } ];

          uniqFlatListOf =
            elemType:
            lib.mkOptionType {
              name = "uniqFlatListOf";
              inherit (listOf elemType) description descriptionClass;
              check = isList;
              merge = mergeUniq (
                file: loc: lib.imap1 (i: mergeFlat elemType (loc ++ [ "[entry ${toString i}]" ]) file)
              );
            };

          uniqFlatAttrsOf =
            elemType:
            lib.mkOptionType {
              name = "uniqFlatAttrsOf";
              inherit (attrsOf elemType) description descriptionClass;
              check = isAttrs;
              merge = mergeUniq (file: loc: lib.mapAttrs (name: mergeFlat elemType (loc ++ [ name ]) file));
            };

          kdlUntypedValue = lib.mkOptionType {
            name = "kdlUntypedValue";
            description = "KDL value without type annotation";
            descriptionClass = "noun";

            inherit
              (nullOr (oneOf [
                str
                bool
                number
                path
              ]))
              check
              merge
              ;
          };

          kdlTypedValue = lib.mkOptionType {
            name = "kdlTypedValue";
            description = "KDL value with type annotation";
            descriptionClass = "noun";

            check = isAttrs;
            merge =
              let
                base = submodule {
                  options = {
                    type = lib.mkOption {
                      type = nullOr str;
                      default = null;
                      description = ''
                        [Type annotation](https://kdl.dev/spec/#name-type-annotation) of a [KDL value](https://kdl.dev/spec/#name-value).
                      '';
                    };
                    value = lib.mkOption {
                      type = kdlUntypedValue;
                      description = ''
                        Scalar part of a [KDL value](https://kdl.dev/spec/#name-value)
                      '';
                    };
                  };
                };
              in
              loc: defs: base.merge loc defs;
          };

          # https://kdl.dev/spec/#name-value
          kdlValue =

            let
              base = coercedTo kdlUntypedValue (value: { inherit value; }) kdlTypedValue;
            in

            lib.mkOptionType {
              name = "kdlValue";
              description = "KDL value";
              descriptionClass = "noun";

              check = v: base.check v;
              merge = loc: defs: base.merge loc defs;

              nestedTypes = {
                type = nullOr str;
                scalar = kdlUntypedValue;
              };
            };

          # https://kdl.dev/spec/#name-node
          kdlNode = lib.mkOptionType {
            name = "kdlNode";
            description = "KDL node";
            descriptionClass = "noun";

            check = isAttrs;
            merge =
              let
                base = submodule {
                  options = {
                    type = lib.mkOption {
                      type = nullOr str;
                      default = null;
                      description = ''
                        [Type annotation](https://kdl.dev/spec/#name-type-annotation) of a KDL node.
                      '';
                    };
                    name = lib.mkOption {
                      type = str;
                      description = ''
                        Name of a [KDL node](https://kdl.dev/spec/#name-node).
                      '';
                    };
                    arguments = lib.mkOption {
                      type = uniqFlatListOf kdlValue;
                      default = [ ];
                      description = ''
                        [Arguments](https://kdl.dev/spec/#name-argument) of a KDL node.
                      '';
                    };
                    properties = lib.mkOption {
                      type = uniqFlatAttrsOf kdlValue;
                      default = { };
                      description = ''
                        [Properties](https://kdl.dev/spec/#name-property) of a KDL node.
                      '';
                    };
                    children = lib.mkOption {
                      type = kdlDocument;
                      default = [ ];
                      description = ''
                        [Children](https://kdl.dev/spec/#children-block) of a KDL node.
                      '';
                    };
                  };
                };
              in
              loc: defs: base.merge loc defs;

            nestedTypes = {
              name = str;
              type = nullOr str;
              arguments = uniqFlatListOf kdlValue;
              properties = uniqFlatAttrsOf kdlValue;
              children = kdlDocument;
            };
          };

          kdlDocument = lib.mkOptionType {
            name = "kdlDocument";
            description = "KDL document";
            descriptionClass = "noun";

            check = isList;
            merge = mergeUniq (
              file:
              let
                mergeDocument =
                  loc: toplevel:
                  builtins.concatLists (
                    lib.imap1 (i: mergeDocumentEntry (loc ++ [ "[entry ${toString i}]" ])) toplevel
                  );

                mergeDocumentEntry =
                  loc: value:
                  let
                    inherit (lib.options) showDefs;
                    defs = [ { inherit file value; } ];
                  in
                  if isList value then
                    mergeDocument loc value
                  else if value ? _type then
                    if value._type == "if" then
                      if isBool value.condition then
                        if value.condition then mergeDocumentEntry loc value.content else [ ]
                      else
                        throw "`mkIf` called with non-Boolean condition at ${lib.showOption loc}. Definition value:${showDefs defs}"
                    else if value._type == "merge" then
                      throw ''
                        ${lib.showOption loc} has wrong type: expected a KDL node or document, got 'merge'.
                        note: `mkMerge` is potentially ambiguous in a KDL document, as "merging" is application-specific. if you intended to "splat" all the nodes in a KDL document, you can just insert the list of nodes directly. you can arbitrarily nest KDL documents, and they will be concatenated.
                      ''
                    else
                      throw "${lib.showOption loc} has wrong type: expected a KDL node or document, got '${value._type}'. Definition value:${showDefs defs}"
                  else if kdlNode.check value then
                    [ (kdlNode.merge loc [ { inherit file value; } ]) ]
                  else
                    throw "${lib.showOption loc} has wrong type: expected a KDL node or document. Definition value:${showDefs defs}";
              in
              mergeDocument
            );

            nestedTypes.node = kdlNode;
          };
        in
        kdlDocument
      );

      lib = {
        /**
          Helper function for generating attrsets expected by pkgs.formats.kdl
          # Example
          ```nix
          let
            settingsFormat = pkgs.formats.kdl { };
            inherit (settingsFormat.lib) node;
          in
          settingsFormat.generate "sample.kdl" [
            (node "foo" null [ ] { } [
              (node "bar" null [ "baz" ] { a = 1; } [ ])
            ])
          ]
          ```
          # Arguments
          name
          : The name of the node, represented by a string
          type
          : The type annotation of the node, represented by a string, or null to avoid generating a type annotation
          arguments
          : The arguments of the node, represented as a list of KDL values
          properties
          : The properties of the node, represented as an attrset of KDL values
          children
          : The children of the node, represented as a list of nodes
        */
        node = name: type: arguments: properties: children: {
          inherit
            name
            type
            arguments
            properties
            children
            ;
        };

        /**
          Helper function for generating the format of a typed value as expected by pkgs.formats.kdl
          type
          : The type of the value, represented by a string
          value
          : The value itself
        */
        typed = type: value: { inherit type value; };
      };

      generate =
        name: value:
        pkgs.callPackage (
          { runCommand, jsonkdl }:
          runCommand name
            {
              nativeBuildInputs = [ jsonkdl ];
              value = builtins.toJSON value;
              passAsFile = [ "value" ];
            }
            ''
              jsonkdl --kdl-v${builtins.toString version} -- "$valuePath" "$out"
            ''
        ) { };
    };
}
