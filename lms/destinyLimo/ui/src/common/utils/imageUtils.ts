export default function resizeImage(file: File, maxWidth: number, maxHeight: number, callback: (resizedImage: File) => void): void {
    const reader = new FileReader();
    reader.onload = (event: any) => {
        const img = new Image();
        img.onload = () => {
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d');

            let width = img.width;
            let height = img.height;

            if (width > height) {
                if (width > maxWidth) {
                    height = Math.round((height *= maxWidth / width));
                    width = maxWidth;
                }
            } else {
                if (height > maxHeight) {
                    width = Math.round((width *= maxHeight / height));
                    height = maxHeight;
                }
            }

            canvas.width = width;
            canvas.height = height;
            ctx?.drawImage(img, 0, 0, width, height);

            canvas.toBlob((blob) => {
                const resizedImage = new File([blob!], file.name, { type: file.type });
                callback(resizedImage);
            }, file.type);
        };
        img.src = event.target.result;
    };
    reader.readAsDataURL(file);
}
