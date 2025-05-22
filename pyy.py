from PIL import Image
import os
import json
import shutil

# --- Config ---

input_path = r"D:/snap_deals/3333r.png"  # Your source icon image (must be square)

android_res_path = r"D:/snap_deals/android/app/src/main/res"
ios_appiconset_path = r"D:/snap_deals/ios/Runner/Assets.xcassets/AppIcon.appiconset"

output_dir = "output_icons"
android_dir = os.path.join(output_dir, "android")
ios_dir = os.path.join(output_dir, "ios")

android_sizes = {
    "mipmap-mdpi": 48,
    "mipmap-hdpi": 72,
    "mipmap-xhdpi": 96,
    "mipmap-xxhdpi": 144,
    "mipmap-xxxhdpi": 192,
}

# iOS icon sizes with scale factors for Contents.json
ios_icons = [
    {"size": "20x20", "scales": [1, 2, 3], "idiom": "iphone"},
    {"size": "29x29", "scales": [1, 2, 3], "idiom": "iphone"},
    {"size": "40x40", "scales": [1, 2, 3], "idiom": "iphone"},
    {"size": "60x60", "scales": [2, 3], "idiom": "iphone"},
    {"size": "20x20", "scales": [1, 2], "idiom": "ipad"},
    {"size": "29x29", "scales": [1, 2], "idiom": "ipad"},
    {"size": "40x40", "scales": [1, 2], "idiom": "ipad"},
    {"size": "76x76", "scales": [1, 2], "idiom": "ipad"},
    {"size": "83.5x83.5", "scales": [2], "idiom": "ipad"},
    {"size": "1024x1024", "scales": [1], "idiom": "ios-marketing"},
]

def parse_size(size_str):
    # Converts "20x20" or "83.5x83.5" to float tuple (w, h)
    w, h = size_str.split('x')
    return float(w), float(h)

# Create output folders
os.makedirs(android_dir, exist_ok=True)
os.makedirs(ios_dir, exist_ok=True)

# Load source image
try:
    img = Image.open(input_path)
    if img.width != img.height:
        print(f"Warning: source image is not square ({img.width}x{img.height})")
    print(f"Loaded image size: {img.size}, mode: {img.mode}")
except FileNotFoundError:
    print(f"Error: File not found at {input_path}")
    exit(1)
except Exception as e:
    print(f"Error loading image: {e}")
    exit(1)

def save_android_icons():
    print("Generating Android icons...")
    for folder, size in android_sizes.items():
        folder_path = os.path.join(android_dir, folder)
        os.makedirs(folder_path, exist_ok=True)
        resized = img.resize((size, size), Image.Resampling.LANCZOS)
        save_path = os.path.join(folder_path, "ic_launcher.png")
        resized.save(save_path)
        print(f"Saved Android icon: {folder}/ic_launcher.png ({size}x{size})")

def save_ios_icons():
    print("Generating iOS icons...")
    ios_appiconset_dir = os.path.join(ios_dir, "AppIcon.appiconset")
    os.makedirs(ios_appiconset_dir, exist_ok=True)
    contents_images = []

    for icon in ios_icons:
        base_w, base_h = parse_size(icon["size"])
        idiom = icon["idiom"]
        for scale in icon["scales"]:
            size_px = int(round(base_w * scale))
            resized = img.resize((size_px, size_px), Image.Resampling.LANCZOS)

            # Create filename like Icon-20x20@2x.png or Icon-83.5x83.5@2x.png
            scale_suffix = "" if scale == 1 else f"@{scale}x"
            # Replace '.' in size for filename with underscore or just keep dot? iOS uses dot in size, so keep it
            filename = f"Icon-{icon['size']}{scale_suffix}.png"
            save_path = os.path.join(ios_appiconset_dir, filename)
            resized.save(save_path)
            print(f"Saved iOS icon: {filename} ({size_px}x{size_px})")

            # Add entry to Contents.json images array
            contents_images.append({
                "size": icon["size"],
                "idiom": idiom,
                "filename": filename,
                "scale": f"{scale}x"
            })

    # Generate Contents.json
    contents = {
        "images": contents_images,
        "info": {
            "version": 1,
            "author": "xcode"
        }
    }
    contents_path = os.path.join(ios_appiconset_dir, "Contents.json")
    with open(contents_path, "w") as f:
        json.dump(contents, f, indent=4)
    print(f"Generated Contents.json at {contents_path}")

def copy_android_to_project():
    print("Copying Android icons to project...")
    for folder in android_sizes.keys():
        src = os.path.join(android_dir, folder, "ic_launcher.png")
        dst_folder = os.path.join(android_res_path, folder)
        os.makedirs(dst_folder, exist_ok=True)
        dst = os.path.join(dst_folder, "ic_launcher.png")
        shutil.copy2(src, dst)
        print(f"Copied {src} to {dst}")

def copy_ios_to_project():
    print("Copying iOS icons to project...")
    src_folder = os.path.join(ios_dir, "AppIcon.appiconset")
    os.makedirs(ios_appiconset_path, exist_ok=True)
    for filename in os.listdir(src_folder):
        src = os.path.join(src_folder, filename)
        dst = os.path.join(ios_appiconset_path, filename)
        shutil.copy2(src, dst)
        print(f"Copied {src} to {dst}")

if __name__ == "__main__":
    save_android_icons()
    save_ios_icons()

    copy_android_to_project()
    copy_ios_to_project()

    print("Icon generation and copying complete! Please rebuild your app to see changes.")
