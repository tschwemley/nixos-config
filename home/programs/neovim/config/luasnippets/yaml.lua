return {
   s("ingress", t([[
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name:
  namespace:
  annotations:
    cert-manager.io/cluster-issuer: prod-issuer
spec:
  ingressClassName: nginx
  rules:
  - host:
    http:
      paths:
      - pathType: ImplementationSpecific
        path: /
        backend:
          service:
            name:
            port:
              number:
  tls:
  - hosts:
    -
    secretName:
   ]]))
}
