# Tutorial de Terraform para Iniciantes

## Introdução

Terraform é uma ferramenta de infraestrutura como código (IaC) desenvolvida pela HashiCorp, que permite gerenciar, provisionar e atualizar recursos de infraestrutura em nuvens públicas, privadas e híbridas. Neste tutorial, abordaremos os conceitos básicos do Terraform e como começar a usá-lo.

## 1. Instalação do Terraform

Antes de começar, você deve instalar o Terraform em seu computador. Siga as instruções oficiais para instalar o Terraform no seu sistema operacional: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

## 2. Configuração do ambiente

Para começar, crie uma pasta para armazenar seus arquivos de configuração do Terraform. Neste exemplo, criaremos uma pasta chamada "meu_projeto_terraform":

  mkdir meu_projeto_terraform
  cd meu_projeto_terraform


## 3. Criando um arquivo de configuração Terraform

Os arquivos de configuração do Terraform têm a extensão ".tf". Crie um arquivo chamado "main.tf" com o seguinte conteúdo:

```
provider "aws" {
  region = "us-east-1"
}

# Busca a AMI mais recente do Ubuntu 24.04 LTS publicada pela Canonical,
# em vez de fixar um ID que deixa de existir quando a AMI é descontinuada
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example-instance"
  }
}
```

Neste exemplo, estamos usando o provedor AWS (Amazon Web Services) e criando uma instância EC2 (Elastic Compute Cloud) na região "us-east-1" com o tipo "t2.micro".

O bloco `data "aws_ami"` busca a imagem mais recente do Ubuntu 24.04 LTS publicada pela Canonical. Isso evita fixar o ID de uma AMI no código: as AMIs antigas são descontinuadas e, quando isso acontece, um ID fixo deixa de funcionar.

## 4. Credenciais da AWS

O Terraform usa as mesmas credenciais do AWS CLI. No AWS Academy Learner Lab, as credenciais são temporárias e mudam a cada sessão: em **AWS Details > AWS CLI: Show**, copie os valores e exporte as três variáveis de ambiente (sem o `AWS_SESSION_TOKEN`, o `terraform plan` falha com erro de credencial):

  export AWS_ACCESS_KEY_ID=...
  export AWS_SECRET_ACCESS_KEY=...
  export AWS_SESSION_TOKEN=...

No Windows (PowerShell), use `$env:AWS_ACCESS_KEY_ID="..."` e assim por diante. Outra opção é colar o bloco copiado no arquivo `~/.aws/credentials`. Repita este passo sempre que iniciar uma nova sessão do laboratório.

## 5. Inicializando o Terraform

No diretório do projeto, execute o seguinte comando para inicializar o Terraform:

  terraform init

Este comando baixa o provedor necessário (neste caso, o provedor AWS) e cria um diretório chamado ".terraform".

## 6. Verificando a configuração do Terraform

Antes de aplicar as mudanças, você pode verificar o plano de execução do Terraform com o comando "terraform plan". Isso exibirá as mudanças que serão feitas na sua infraestrutura:

  terraform plan

## 7. Aplicando a configuração do Terraform

Para aplicar as mudanças, execute o comando "terraform apply". Este comando criará a instância EC2 na sua conta AWS:

  terraform apply

Confirme a ação digitando "yes" quando solicitado.

## 8. Verificando os recursos criados

Você pode verificar os recursos criados no console AWS ou executando o seguinte comando:

  terraform show


## 9. Destruindo a infraestrutura criada

Para destruir os recursos criados, execute o comando "terraform destroy". Isso excluirá a instância EC2 e quaisquer outros recursos criados:

  terraform destroy

Confirme a ação digitando "yes" quando solicitado.

## Conclusão:

Neste tutorial, você aprendeu o básico do Terraform, como instalar a ferramenta, criar um arquivo de configuração, inicializar o ambiente, verificar e aplicar a configuração e destruir os recursos criados. À medida que você se familiariza com o Terraform
