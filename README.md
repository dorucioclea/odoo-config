# Odoo Config

This repository contains a Docker-powered setup for running and managing an [Odoo](https://www.odoo.com/) instance. Odoo is a suite of open-source enterprise management applications, including CRM, e-commerce, accounting, inventory, and project management, among others. The setup uses `docker-compose` to orchestrate the required services, making it easy to deploy and maintain.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Backup and Restore](#backup-and-restore)
- [Updating Odoo](#updating-odoo)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have Docker and Docker Compose installed on your system.
- You have a basic understanding of how Docker and Docker Compose work.
- You have a basic understanding of Odoo and its architecture.

## Installation

To set up the Odoo Config, follow these steps:

1. Clone the repository:

```bash
    git clone https://github.com/dorucioclea/odoo-config.git
```

2. Navigate to the repository folder:

```bash
cd odoo-config
```

## Configuration

The configuration files are located in the `provisioning/odoo` directory. These files can be customized according to your Odoo instance and preferences. The main configuration file is `odoo.conf.template`, which includes settings related to the database, and other Odoo-specific configurations. This file is processed by `envsubst` to substitute its values with the environment variables that are passed to the container.

Additionally, the `docker-compose.yml` file contains the configuration for the Docker Compose services, including the Odoo application and its PostgreSQL database. You may need to adjust the environment variables, volume paths, and other settings depending on your deployment environment.

## Usage

To start the Odoo instance using Docker Compose, run the following command from the project root:

```bash
docker-compose up --build
```


This will start the Odoo application and its PostgreSQL database in detached mode. You can now access the Odoo web interface at `http://localhost:8069` . You can login with username/password : `admin / admin`

To stop the services, run the following command:

```bash
docker-compose down
```

To cleanup everything you can run: 

```bash
docker-compose down --rmi all --volumes
```

## Backup and Restore

To create a backup of your Odoo instance, follow these steps:

1. Access the Odoo web interface and navigate to the Settings app.
2. Click on "Backups" under the General Settings menu.
3. Click on "Create Backup" and choose the backup format (zip or dump).

To restore a backup:

1. Access the Odoo web interface and navigate to the Settings app.
2. Click on "Backups" under the General Settings menu.
3. Click on "Restore Backup" and choose the backup file from your local machine.

## Updating Odoo

To update your Odoo instance:

1. Pull the latest version of the Odoo Docker image:

```bash
docker pull odoo:VERSION
```

Replace `VERSION` with the desired Odoo version (e.g., `16.0`).

2. Update the `docker-compose.yml` file with the new Odoo image version, if necessary.
3. Restart the services using Docker Compose:

```
docker-compose down && docker-compose up --build
```

## Contributing

If you want to contribute to this project, please submit a pull request or create an issue to discuss your proposed changes.

## License

This project is released under the MIT License. See the [License](LICENSE) file for more details.

