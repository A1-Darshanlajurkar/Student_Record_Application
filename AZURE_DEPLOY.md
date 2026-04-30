# Azure Deployment Guide — Student Records App

## Architecture

```
Browser (HTML/CSS)
       |
       v
  Azure App Service  (Tomcat 9 + JSP Servlet)
       |
       v
  Azure Database for MySQL Flexible Server
```

---

## Prerequisites

- Azure CLI installed: `az --version`
- Maven 3.8+ installed: `mvn --version`
- Java 11+ installed: `java --version`
- An Azure subscription

---

## Step 1 — Create Azure Resources

```bash
# Login
az login

# Create Resource Group
az group create --name student-records-rg --location eastus

# Create Azure MySQL Flexible Server
az mysql flexible-server create \
  --resource-group student-records-rg \
  --name student-mysql-server \
  --location eastus \
  --admin-user adminuser \
  --admin-password "YourP@ssword123" \
  --sku-name Standard_B1ms \
  --tier Burstable \
  --storage-size 20 \
  --version 8.0.21 \
  --public-access 0.0.0.0

# Create the database
az mysql flexible-server db create \
  --resource-group student-records-rg \
  --server-name student-mysql-server \
  --database-name studentdb
```

---

## Step 2 — Run the SQL Schema

```bash
# Allow your current IP (replace with your actual IP)
az mysql flexible-server firewall-rule create \
  --resource-group student-records-rg \
  --name student-mysql-server \
  --rule-name AllowMyIP \
  --start-ip-address <YOUR_IP> \
  --end-ip-address <YOUR_IP>

# Connect and run schema
mysql -h student-mysql-server.mysql.database.azure.com \
      -u adminuser -p studentdb < sql/schema.sql
```

---

## Step 3 — Create the App Service

```bash
# Create App Service Plan (Linux B1)
az appservice plan create \
  --name student-app-plan \
  --resource-group student-records-rg \
  --is-linux \
  --sku B1

# Create Web App with Java 11 + Tomcat 9
az webapp create \
  --resource-group student-records-rg \
  --plan student-app-plan \
  --name student-records-app \
  --runtime "TOMCAT:9.0-java11"
```

---

## Step 4 — Configure App Settings (Environment Variables)

```bash
az webapp config appsettings set \
  --resource-group student-records-rg \
  --name student-records-app \
  --settings \
    DB_URL="jdbc:mysql://student-mysql-server.mysql.database.azure.com:3306/studentdb?useSSL=true&requireSSL=false&serverTimezone=UTC" \
    DB_USER="adminuser@student-mysql-server" \
    DB_PASSWORD="YourP@ssword123"
```

---

## Step 5 — Allow App Service to reach MySQL

```bash
# Get outbound IPs of your App Service
az webapp show \
  --resource-group student-records-rg \
  --name student-records-app \
  --query outboundIpAddresses --output tsv

# Add each IP to MySQL firewall (repeat for each IP)
az mysql flexible-server firewall-rule create \
  --resource-group student-records-rg \
  --name student-mysql-server \
  --rule-name AllowAppService \
  --start-ip-address <APP_SERVICE_IP> \
  --end-ip-address <APP_SERVICE_IP>
```

---

## Step 6 — Build & Deploy

```bash
# Edit pom.xml: replace YOUR_SUBSCRIPTION_ID
# Then deploy:

mvn clean package
mvn azure-webapp:deploy
```

The app will be live at:
```
https://student-records-app.azurewebsites.net/StudentApp/
```

---

## Local Development

1. Install MySQL locally and run `sql/schema.sql`
2. Update `DBConnection.java` fallback values OR set env vars:
   ```bash
   export DB_URL=jdbc:mysql://localhost:3306/studentdb?useSSL=false
   export DB_USER=root
   export DB_PASSWORD=root
   ```
3. Run with embedded Tomcat:
   ```bash
   mvn clean package
   # Deploy the WAR to local Tomcat, or use:
   mvn tomcat7:run
   ```
   Then open: http://localhost:8080/StudentApp/

---

## Connection Flow Summary

```
index.jsp  ──(HTML form POST)──►  StudentServlet.doPost()
                                       │
                                       ▼
                                  StudentDAO.addStudent()
                                       │
                                       ▼
                                  DBConnection.getConnection()
                                       │
                      reads env vars: DB_URL / DB_USER / DB_PASSWORD
                                       │
                                       ▼
                              Azure MySQL Flexible Server
                                  (studentdb.students)
```
