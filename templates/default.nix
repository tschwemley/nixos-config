{
  flake.templates = {
    go = {
      path = ./go/basic;
      description = "Basic go application";
    };
    go-web = {
      path = ./go/web;
      description = "Go web application w/ Echo and Templ";
    };
    node = {
      path = ./node;
      description = "Basic node application";
    };
    php = {
      path = ./php;
      description = "Basic php application";
    };
    python = {
      path = ./python;
      description = "Basic python application";
    };
  };
}
