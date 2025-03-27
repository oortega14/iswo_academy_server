## Configuración del entorno

1. Copia el archivo de ejemplo:

   ```bash
   cp .env.example .env
   ```

2. Configura tus variables de entorno en `.env`:
   - AWS: Configura tus credenciales de AWS
   - Mercado Pago: Configura tus credenciales de MP
   - Rails: Configura tu master key
   - Frontend: Ajusta la URL según tu entorno

### Variables requeridas:

#### AWS

- `AWS_ACCESS_KEY_ID`: Tu Access Key de AWS
- `AWS_SECRET_ACCESS_KEY`: Tu Secret Key de AWS
- `AWS_BUCKET`: Nombre de tu bucket S3
- `AWS_REGION`: Región de AWS (ej: us-east-1)

#### Mercado Pago

- `MERCADOPAGO_ACCESS_TOKEN`: Token de acceso de MP
- `MERCADOPAGO_PUBLIC_KEY`: Clave pública de MP

#### Rails

- `RAILS_ENV`: Entorno de Rails (development/production)
- `RAILS_MASTER_KEY`: Master key de Rails

#### Frontend

- `FRONT_URL`: URL de tu aplicación frontend
