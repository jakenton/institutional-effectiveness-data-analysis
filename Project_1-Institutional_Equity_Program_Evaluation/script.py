# The following code automatically imports the data fields selected into a pandas DataFrame called 'dataset'.

# --- Data Preparation & Aggregation (Uses only Pandas) ---
# Removes rows where Demographic_Group is INSTITUTIONAL TOTAL or Combined, as these skew the average risk calculation.
dataset = dataset[
    (dataset['demographic_group'] != 'INSTITUTIONAL TOTAL') & 
    (dataset['demographic_group'] != 'Combined')
]

# Groups the data to show average risk score by demographic
df_agg = dataset.groupby('demographic_group')['Risk_Score'].mean().reset_index()

# --- Visualization (Uses only Matplotlib, which is guaranteed to be available) ---
import matplotlib.pyplot as plt
# NOTE: Removed 'import seaborn as sns'

# Sets a consistent figure size for the dashboard
plt.figure(figsize=(10, 6)) 

# Calculates the overall average risk line
overall_avg_risk = df_agg['Risk_Score'].mean()

# Use Matplotlib's bar function
# Maps the demographic group names to the x-axis and the scores to the height
bars = plt.bar(
    x=df_agg['demographic_group'], 
    height=df_agg['Risk_Score'],
    # Uses generic Matplotlib colors instead of a Seaborn palette
    color=['#003A70', '#E35205', '#F6BE00', '#2C99D8'] 
)

# Adds the overall average risk line (crucial for comparison)
plt.axhline(overall_avg_risk, color='red', linestyle='--', linewidth=2, label='Overall Avg Risk')

# Sets titles and labels
plt.title('Average Enrollment Risk Score by Demographic Group (Predictive Model)')
plt.ylabel('Average Predictive Risk Score (0-100)')

# Sets the Y-axis explicitly from 0 to 100 for accurate representation and spacing
plt.ylim(0, 100) 

# Rotates labels for better fit
plt.xticks(rotation=45, ha='right')

# Adds data labels on top of the bars
for bar in bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, yval + 1, round(yval, 1), ha='center', va='bottom')

plt.legend(loc='upper right')
plt.tight_layout() # Adjust layout to prevent clipping
plt.show()