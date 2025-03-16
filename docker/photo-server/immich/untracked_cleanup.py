import argparse
import os


def update_paths(files: list[str]) -> list[str]:
    updated_files = []
    for file in files:
        if file.startswith("/usr/src/app/upload"):
            updated_files.append(
                file.replace("/usr/src/app/upload/", "/mnt/photos/").strip()
            )

    return updated_files


def cleanup_files(files: list[str]):
    for file in files:
        if os.path.exists(file):
            os.remove(file)
        else:
            print(f"File {file} does not exist.")


def main(file_path: str):
    with open(f"{os.getcwd()}/{file_path}", "r") as f:
        file = f.readlines()
    paths = update_paths(file)
    cleanup_files(paths)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process a file for cleanup.")
    parser.add_argument("file", type=str, help="The file to be processed")
    args = parser.parse_args()
    main(args.file)
