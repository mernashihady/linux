import argparse
import matplotlib.pyplot as plt

def plot_plant_data(plant_name, height, leaf_count, dry_weight):
    """ יוצר דיאגרמות נתונים של צמח """
    
    
    plt.figure(figsize=(6, 4))
    plt.scatter(height, leaf_count, color='green', marker='o')
    plt.xlabel('Height (cm)')
    plt.ylabel('Leaf Count')
    plt.title(f'Scatter Plot - {plant_name}')
    plt.savefig(f"{plant_name}_scatter.png")
    plt.close()

    
    plt.figure(figsize=(6, 4))
    plt.hist(dry_weight, bins=5, color='blue', alpha=0.7)
    plt.xlabel('Dry Weight (g)')
    plt.ylabel('Frequency')
    plt.title(f'Histogram - {plant_name}')
    plt.savefig(f"{plant_name}_histogram.png")
    plt.close()

   
    plt.figure(figsize=(6, 4))
    plt.plot(height, dry_weight, marker='o', linestyle='-', color='red')
    plt.xlabel('Height (cm)')
    plt.ylabel('Dry Weight (g)')
    plt.title(f'Line Plot - {plant_name}')
    plt.savefig(f"{plant_name}_line_plot.png")
    plt.close()

    print(f"Generated plots for {plant_name}:")
    print(f" - Scatter plot saved as {plant_name}_scatter.png")
    print(f" - Histogram saved as {plant_name}_histogram.png")
    print(f" - Line plot saved as {plant_name}_line_plot.png")


parser = argparse.ArgumentParser(description="Generate plant growth plots.")
parser.add_argument("--plant", type=str, required=True, help="Name of the plant")
parser.add_argument("--height", type=float, nargs='+', required=True, help="List of plant heights in cm")
parser.add_argument("--leaf_count", type=int, nargs='+', required=True, help="List of leaf counts")
parser.add_argument("--dry_weight", type=float, nargs='+', required=True, help="List of dry weights in grams")
args = parser.parse_args()


plot_plant_data(args.plant, args.height, args.leaf_count, args.dry_weight)
