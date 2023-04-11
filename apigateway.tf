# API Gateway
resource "aws_api_gateway_rest_api" "app_api" {
  name = var.app_name
}

resource "aws_api_gateway_deployment" "app_api_deployment" {
  depends_on  = [aws_api_gateway_integration.app_api_integration]
  rest_api_id = aws_api_gateway_rest_api.app_api.id
  stage_name  = "prod"
}

resource "aws_api_gateway_resource" "app_resource" {
  rest_api_id = aws_api_gateway_rest_api.app_api.id
  parent_id   = aws_api_gateway_rest_api.app_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "app_method" {
  rest_api_id   = aws_api_gateway_rest_api.app_api.id
  resource_id   = aws_api_gateway_resource.app_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "app_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.app_api.id
  resource_id             = aws_api_gateway_resource.app_resource.id
  http_method             = aws_api_gateway_method.app_method.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "http://${aws_lb.app_lb.dns_name}/{proxy}"
}
