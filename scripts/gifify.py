import os
import subprocess
from pathlib import Path
import argparse

def convert_video_to_gif(video_path, output_title, speed=2.0):
    try:
        # Define the path to the output GIF (on desktop)
        desktop = Path.home() / 'Desktop'
        output_path = desktop / f"{output_title}.gif"
        
        # Set the speed filter based on the speed argument
        setpts_value = f"{1/speed}*PTS"
        
        # ffmpeg command to convert video to gif
        command = [
            'ffmpeg', '-i', video_path, 
            '-vf', f'setpts={setpts_value},scale=640:-1:flags=lanczos', 
            '-r', '15', str(output_path)
        ]
        
        # Run the ffmpeg command
        subprocess.run(command, check=True)
        
        print(f"GIF created successfully at: {output_path}")
    except subprocess.CalledProcessError as e:
        print(f"Error converting video to GIF: {e}")

if __name__ == "__main__":
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Convert a video to a GIF, default is 2x speed.")
    parser.add_argument('video_file', help="Path to the input video file")
    parser.add_argument('title', nargs='?', help="Title for the output GIF (optional)")
    parser.add_argument('--slow', action='store_true', help="Export GIF at real-time speed (default is 2x speed)")

    # Parse arguments
    args = parser.parse_args()

    # If no title is provided, ask the user for a title
    if not args.title:
        args.title = input("Enter a title for the GIF: ")

    # Check if the file exists
    if not os.path.isfile(args.video_file):
        print("The file doesn't exist. Please provide a valid file.")
    else:
        # Determine speed (default 2x unless --slow is specified)
        speed = 1.0 if args.slow else 2.0
        
        # Call the function to convert the video to a GIF
        convert_video_to_gif(args.video_file, args.title, speed)

