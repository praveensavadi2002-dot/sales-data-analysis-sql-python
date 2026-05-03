import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv("sales_data.csv")

# Create total column
df["total"] = df["quantity"] * df["price"]

# Convert date
df["order_date"] = pd.to_datetime(df["order_date"])
df["month"] = df["order_date"].dt.month

# =========================
# 📊 Monthly Revenue Analysis
# =========================

monthly_sales = df.groupby("month")["total"].sum().sort_index()

# Convert month numbers to names
monthly_sales.index = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

# Plot Monthly Revenue
ax = monthly_sales.plot(kind='bar')

for i, v in enumerate(monthly_sales):
    ax.text(i, v, str(v), ha='center', va='bottom')

plt.title("Monthly Revenue")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.xticks(rotation=0)
plt.tight_layout()

plt.show()


# =========================
# 📊 Category-wise Analysis
# =========================

category_sales = df.groupby("category")["total"].sum()

print("\nCategory-wise Sales:\n")
print(category_sales)

# Plot Category Sales
category_sales.plot(kind='bar')

plt.title("Sales by Category")
plt.xlabel("Category")
plt.ylabel("Revenue")
plt.tight_layout()

plt.show()
