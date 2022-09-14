# rds-lab

> **Steps**:
Make sure to execute this exercise by following the steps in the right order:
> - [Step 1: Setup Github](#step1)
> - [Step 2: Set up Terraform code for RDS](#step2)
> - [Step 3: Deploy your infrastructure](#step3)
> - [Step 4: Set up your EC2 instance](#step4)
> - [Step 5: Install mysql client](#step5)
> - [Step 6: Connect to the new RDS Database](#step6)
> - [Step 7: SQL Queries](#step7)

## <a name="step1"></a>Step 1: Setup Github

Set up your new repository for RDS. Do not forget to provide a `.gitignore` for Terraform, and a `README.md` file.

## <a name="step2"></a>Step 2: Set up Terraform code for RDS

Create the Terraform code to create the new resources required for RDS. Do not forget to set up the `backend.tf` and `provider.tf` for this new project.

The new resources required for RDS to work:
* New security group that will allow access from the EC2 instance only.
* Using Data Source for VPC and subnet informations.
* A new `Database Subnet Group` resource is required. This requires **at least 2** subnet ID to work.

The **RDS instance** itself can contain the following parameters:
| Parameters         | Expected values |
| -----------        | -----------     |
| Storage            | `20GB`          |
| Engine             | MySQL, [version 8.0](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MySQL.Concepts.VersionMgmt.html) |
| Instance Type      | `db.t3.micro`   |
| Multi AZ           | Yes             |
| Final snapshot     | No              |
| Backup retention   | 1 day           |
| Database Name      | e.g. movies_db  |
| Admin username     | e.g. admin_db   |
| Admin password     | e.g. very_secret_p@ssw0rd |

Try to think of a better solution to keep the password a secret in the Terraform code, and to **avoid the risk** of having it in the Git repository in plain text.

## <a name="step3"></a>Step 3: Deploy your infrastructure

Make sure you have exported your **profile** and **region** to start working with terraform.

As always, do not forget to run `terraform init` before running `terraform plan` and `terraform apply`.

## <a name="step4"></a>Step 4: Set up your EC2 instance

If you do not already have an existing EC2 instance running, you can set up a new one within the same terraform repository for this exercise.

If you already have an EC2 instance, you can ssh into it and continue with the next step.

## <a name="step5"></a>Step 5: Install mysql client
Installing the mysql client is a simple task.

```sh
    # Install mysql client
    sudo apt-get update
    sudo apt-get install mysql-client
```
## <a name="step6"></a>Step 6: Connect to the new RDS Database

Connect to the new RDS Database using the following command. It'll ask you for the password so you can type in the same as you did when you created the RDS instance.

```sh
    # Connect to the new RDS Database
    mysql -u username -h rds-instance-endpoint -p
```

## <a name="step7"></a>Step 7: SQL Queries

Start typing a few sql queries. Start by creating a database:

```sh
    # Create a database
    CREATE DATABASE movies_db;
    USE movies_db;
```

Then create a table:

```sh
    # Create a table
    CREATE TABLE movies (
        id INT NOT NULL AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        year INT NOT NULL,
        PRIMARY KEY (id)
    );
```

Then insert some data:

```sh
    # Insert some data
    INSERT INTO movies (title, year) VALUES ('The Shawshank Redemption', 1994);
    INSERT INTO movies (title, year) VALUES ('The Godfather', 1972);
    INSERT INTO movies (title, year) VALUES ('The Godfather: Part II', 1974);
    INSERT INTO movies (title, year) VALUES ('The Dark Knight', 2008);
    INSERT INTO movies (title, year) VALUES ('12 Angry Monkeys', 1999);
    INSERT INTO movies (title, year) VALUES ('Pulp Fiction', 1994);
    INSERT INTO movies (title, year) VALUES ('The Lord of the Rings: The Return of the King', 2003);
    INSERT INTO movies (title, year) VALUES ('Fight Club', 1999);
    INSERT INTO movies (title, year) VALUES ('The Lord of the Rings: The Fellowship of the Ring', 2001);
    INSERT INTO movies (title, year) VALUES ('Star Wars: Episode V - The Empire Strikes Back', 1980);
    INSERT INTO movies (title, year) VALUES ('Forrest Gump', 1994);
    INSERT INTO movies (title, year) VALUES ('Inception', 2010);
    INSERT INTO movies (title, year) VALUES ('The Matrix', 1999);
    INSERT INTO movies (title, year) VALUES ('The Lord of the Rings: The Two Towers', 2002);
    INSERT INTO movies (title, year) VALUES ('The Matrix Reloaded', 2003);
    INSERT INTO movies (title, year) VALUES ('The Matrix Revolutions', 2003);
    INSERT INTO movies (title, year) VALUES ('The Lord of the Rings: The Fellowship of the Ring', 2001);
```

You can start doing some basic SELECT queries on your database, examples: 

```sh
    # Select all movies
    SELECT * FROM movies;
    # Select all movies from the year 2000
    SELECT * FROM movies WHERE year = 2000;
    # Select all movies from the year 2000 and the year 2001
    SELECT * FROM movies WHERE year IN (2000, 2003);
```
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.rds_mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.rds_db_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_instance.web_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.database_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.web_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_secretsmanager_secret.mysql_passwd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.mysql_passwd_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnet.data-a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.data-b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.talent_academy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->