import { environment } from "@src/environments/environment";

export class FilePaths {
    public static readonly TrainingMaterial = "training-material";
    public static readonly ProfilePicture = "profile-pictures";

    private static readonly FilesURL = environment.filesURL.replace(/\/$/, "");
    private static readonly FileServePath = environment.filesServePath.replace(/\/$/, "");
  


    public static GetFileURL(fileName: string, fileType: string): string {
        return `${this.FilesURL}/${this.FileServePath}/${fileType}/${fileName}`;
    }

    public static GetTrainingMaterialFileURL(fileName: string): string {
        return `${this.FilesURL}/${this.FileServePath}/${fileName}`;
    }

    public static GetTrainingMaterialVideoURL(fileName: string): string {
        return `${this.FilesURL}/${this.FileServePath}/${fileName}`;
    }

    public static GetAvatarPath(avatar: string): string {
        if (!avatar || avatar === "" || avatar === "default-avatar.jpg") {
            return `${this.FilesURL}/${this.FileServePath}/${this.ProfilePicture}/default-avatar.jpg`;
        }

        return `${this.FilesURL}/${this.FileServePath}/${this.ProfilePicture}/${avatar}`;
    }
}