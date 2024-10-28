import pandas as pd
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

# Generate synthetic weather data
np.random.seed(42)

# Creating random data for demonstration
data = pd.DataFrame({
    'Temperature': np.random.randint(-10, 30, 100),
    'Humidity': np.random.randint(20, 80, 100),
    'WindSpeed': np.random.randint(0, 15, 100),
})

# Normalize the data
data_normalized = (data - data.mean()) / data.std()

# Choose the number of clusters (you may need to experiment with this)
num_clusters = 3

# Apply K-Means clustering
kmeans = KMeans(n_clusters=num_clusters, random_state=42)
data['Cluster'] = kmeans.fit_predict(data_normalized)

# Assign names to each cluster based on their characteristics
cluster_names = {
    0: 'Mild and Humid',
    1: 'Cold and Dry',
    2: 'Moderate Temperature and Windy',
}

# Map cluster names to the DataFrame
data['ClusterName'] = data['Cluster'].map(cluster_names)

# Visualize the clusters
plt.figure(figsize=(10, 6))

for cluster in range(num_clusters):
    cluster_data = data[data['Cluster'] == cluster]
    plt.scatter(cluster_data['Temperature'], cluster_data['Humidity'], label=cluster_names[cluster])

plt.scatter(kmeans.cluster_centers_[:, 0], kmeans.cluster_centers_[:, 1], s=200, marker='X', c='red', label='Centroids')
plt.xlabel('Temperature')
plt.ylabel('Humidity')
plt.title('Weather Pattern Clustering')
plt.legend()
plt.show()
