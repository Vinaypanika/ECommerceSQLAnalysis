# E-Commerce Dataset Generation using Python

## 📌 Overview
This project generates a **synthetic e-commerce dataset** using Python. The dataset is designed to simulate real-world business operations and includes multiple related tables such as customers, orders, products, payments, and shipping details. The generated dataset can be used for **data analysis, machine learning, and business intelligence** applications.

## 🛠️ Dataset Creation Process
The dataset is generated using **Python** with the help of libraries such as `Faker`, `random`, and `pandas`. The data maintains referential integrity across different tables to ensure realistic relationships between entities.

## 📊 Tables Included
### **1️⃣ Customers Table**
- Customer ID
- First Name
- Last Name
- Email
- State
- Registration Date

### **2️⃣ Products Table**
- Product ID
- Product Name
- Category
- Price
- Seller ID

### **3️⃣ Orders Table**
- Order ID
- Customer ID
- Order Date
- Order Status
- Total Amount

### **4️⃣ Order Items Table**
- Order ID
- Product ID
- Quantity
- Price per Unit
- Total Price

### **5️⃣ Sellers Table**
- Seller ID
- Seller Name
- Total Revenue

### **6️⃣ Inventory Table**
- Product ID
- Stock Quantity
- Last Restocked Date

### **7️⃣ Payments Table**
- Payment ID
- Order ID
- Payment Method
- Payment Status
- Transaction Date

### **8️⃣ Shipping Table**
- Order ID
- Shipping Date
- Delivery Date
- Return Status
- Delivery Time (Days)

## 🔍 Key Analyses Performed
✅ Total unique customers and state-wise distribution
✅ Order trends and revenue analysis
✅ Best-selling and worst-performing products
✅ Customer purchase behavior and average order value (AOV)
✅ Product category-wise sales and profitability
✅ Top-performing sellers and their revenue
✅ Most commonly used payment methods and failure rates
✅ Inventory stock availability and restocking needs
✅ Delivery time analysis and return rate

## 💻 Implementation
- **Libraries Used:** `Faker`, `random`, `pandas`, `numpy`
- **File Format:** CSV (for easy import and analysis)
- **Usage:** Suitable for data analysis, visualization, and predictive modeling

## 🔗 Links
📌 **GitHub Repository:** [Vinay Kumar Panika's GitHub](https://github.com/Vinaypanika)  
📌 **Portfolio:** [Vinay Kumar Panika's Portfolio](https://sites.google.com/view/vinaykumarpanika/home)

## 🚀 How to Use
1️⃣ Clone the repository from GitHub  
2️⃣ Install required Python libraries (`pip install pandas faker numpy`)  
3️⃣ Run the dataset generation script  
4️⃣ Use the CSV files for analysis in Python, SQL, Power BI, or Tableau  

---  
**📌 Created by:** *Vinay Kumar Panika*


