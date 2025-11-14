# -------------------------------
# aws-auth ConfigMap
# -------------------------------
resource "kubernetes_config_map" "aws_auth" {
  depends_on = [module.eks]  # ensure EKS cluster is ready

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    # Map EKS Node Role
    mapRoles = yamlencode([
      {
        rolearn  = module.iam.eks_node_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])

    # Map your AWS root user to Kubernetes admin
    mapUsers = yamlencode([
      {
        userarn  = "arn:aws:iam::742674388365:root"  # your root ARN
        username = "root"
        groups   = ["system:masters"]
      }
    ])
  }
}
