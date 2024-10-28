export class DataGridVideoEditor {
  constructor(editorConfig: any) {
    console.log("in DataGridVideoEditor constructor: ", editorConfig);
  }

  container: any;
  successCallback: any;
  initialValue: any = {};
  returnValue: any = {};
  rootElement: any;
  fileNameLabel: any;
  
  onStart({ container, referencePosition, value, endEdit }: any) {
    console.log("in onStart: ", container, referencePosition, value, endEdit);
    const that = this;
    this.container = container;
    this.successCallback = endEdit;
    this.returnValue = value || {};

    // create root element
    this.rootElement = document.createElement('div');
    this.rootElement.id = 'rootElement' + Math.random();
    this.rootElement.style.position = 'relative';
    this.rootElement.style.padding = '16px';
    this.rootElement.style.background = 'lightgrey';
    this.rootElement.style.display = 'flex';
    this.rootElement.style.flexDirection = 'column';
    this.rootElement.style.alignItems = 'start';
    this.rootElement.style.borderRadius = '8px'; // Rounded corners
    this.rootElement.style.boxShadow = '0 4px 8px rgba(0, 0, 0, 0.4), 0 6px 20px rgba(0, 0, 0, 0.4)'; // Box shadow for raised effect
    this.rootElement.style.border = '.2px solid white';
    
    container.appendChild(this.rootElement);

    // create video URL input
    const videoUrlInput = document.createElement('input');
    videoUrlInput.id = 'videoUrlInput' + Math.random();
    videoUrlInput.type = 'text';
    videoUrlInput.placeholder = 'Enter video URL';
    videoUrlInput.style.width = 'calc(100% - 74px)';
    videoUrlInput.style.padding = '2px 2px'; // Increased padding
    videoUrlInput.style.margin = '0px 4px'; // Margin for spacing
    videoUrlInput.style.boxSizing = 'border-box';
    videoUrlInput.style.border = '2px solid #ccc'; // Stylish border
    videoUrlInput.style.borderRadius = '4px'; // Rounded corners
    videoUrlInput.style.boxShadow = '0 2px 4px rgba(0, 0, 0, 0.1)'; // Subtle shadow
    videoUrlInput.style.fontSize = '13px'; // Font size
    videoUrlInput.style.transition = 'border-color 0.3s'; // Smooth transition for focus effect

    if (value !== null && value !== undefined && value.video && value.video.toLowerCase().startsWith('http')) {
      videoUrlInput.value = value.video;
    }

    // create video URL label
    const videoUrlLabel = document.createElement('label');
    videoUrlLabel.textContent = 'Video URL';
    videoUrlLabel.style.fontSize = '13px';
    videoUrlLabel.style.fontFamily = 'Segoe UI, Tahoma, Geneva, Verdana, sans-serif';
    videoUrlLabel.style.width = '72px';
    videoUrlLabel.style.height = '30px';
    videoUrlLabel.style.padding = '2px';
    videoUrlLabel.style.marginTop = '4px';
    videoUrlLabel.ariaPlaceholder = 'Enter Video URL';

    // create video URL container
    const videoUrlContainer = document.createElement('div');
    videoUrlContainer.style.width = '100%';
    videoUrlContainer.style.height = '30px';
    videoUrlContainer.style.display = 'flex';
    videoUrlContainer.style.flexDirection = 'row';
    videoUrlContainer.style.alignItems = 'middle';
    videoUrlContainer.style.marginBottom = '6px';

    videoUrlContainer.appendChild(videoUrlLabel);
    videoUrlContainer.appendChild(videoUrlInput);

    // create is vimeo checkbox
    const isVimeoCheckbox = document.createElement('input');
    isVimeoCheckbox.id = 'isVimeoCheckbox' + Math.random();
    isVimeoCheckbox.setAttribute('type', 'checkbox');
    isVimeoCheckbox.style.width = '60px';
    isVimeoCheckbox.style.height = '18px';
    isVimeoCheckbox.style.padding = '2px';
    isVimeoCheckbox.style.marginLeft = '-18px';
    isVimeoCheckbox.checked = value !== null && value !== undefined && value.is_vimeo;

    // create is vimeo label
    const isVimeoLabel = document.createElement('label');
    isVimeoLabel.textContent = 'Is Vimeo';
    isVimeoLabel.style.fontSize = '13px';
    isVimeoLabel.style.fontFamily = 'Segoe UI, Tahoma, Geneva, Verdana, sans-serif';
    isVimeoLabel.style.width = '72px';
    isVimeoLabel.style.height = '30px';
    isVimeoLabel.style.padding = '2px';
    isVimeoLabel.style.marginTop = '-4px';

    // create is vimeo container
    const isVimeoContainer = document.createElement('div');
    isVimeoContainer.style.width = '100%';
    isVimeoContainer.style.height = '30px';
    isVimeoContainer.style.display = 'flex';
    isVimeoContainer.style.flexDirection = 'row';
    isVimeoContainer.style.alignItems = 'middle';

    isVimeoContainer.appendChild(isVimeoLabel);
    isVimeoContainer.appendChild(isVimeoCheckbox);

    // create or label
    const orLabel = document.createElement('label');
    orLabel.textContent = 'OR';
    orLabel.style.fontSize = '12px';
    orLabel.style.fontWeight = 'bold';
    orLabel.style.width = '100%';
    orLabel.style.height = '30px';
    orLabel.style.padding = '2px';
    orLabel.style.marginTop = '-4px';

    // create the file upload container
    const fileUploadContainer = document.createElement('div');
    fileUploadContainer.style.width = '100%';
    fileUploadContainer.style.height = '30px';
    fileUploadContainer.style.display = 'flex';
    fileUploadContainer.style.flexDirection = 'row';
    fileUploadContainer.style.alignItems = 'middle';
    fileUploadContainer.style.marginBottom = '-8px';

    // create custom button
    const fileInput = document.createElement('input');
    fileInput.id = 'fileInput' + Math.random();
    fileInput.setAttribute('type', 'file');
    fileInput.style.display = 'none';

    const customButton = document.createElement('button');
    customButton.id = 'customButton' + Math.random();
    customButton.textContent = 'Upload File';
    customButton.style.padding = '4px';
    customButton.style.fontSize = '12px';
    customButton.style.background = 'linear-gradient(to bottom, #4A90E2, #007AFF, #4A90E2)'; // Blue gradient
    customButton.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.3), 0 1px 3px rgba(0, 0, 0, 0.08)'; // Shadow
    customButton.style.textShadow = '1px 1px 2px rgba(0, 0, 0, 0.5)'; // Projected text effect
    customButton.style.color = 'white';
    customButton.style.border = '1px solid grey';
    customButton.style.borderRadius = '8px';
    customButton.style.cursor = 'pointer';
    customButton.style.width = '80px';
    customButton.style.height = '30px';
    customButton.style.marginTop = '-8px';
    //customButton.style.marginBottom = '4px';

    // create is filename label
    this.fileNameLabel = document.createElement('label');
    this.fileNameLabel.id = 'fileNameLabel' + Math.random();
    this.fileNameLabel.style.fontSize = '13px';
    this.fileNameLabel.style.width = 'calc(100% - 80px)';
    this.fileNameLabel.style.height = '20px';
    this.fileNameLabel.style.padding = '2px';
    this.fileNameLabel.style.marginLeft = '4px';
    this.fileNameLabel.style.marginTop = '-6px';
    this.fileNameLabel.style.overflow = 'hidden';

    if (value !== null && value !== undefined && value.video && !value.video.toLowerCase().startsWith('http')) {
      this.fileNameLabel.textContent = value.video;
    }
    else {
      this.fileNameLabel.textContent = 'No file selected';
    }

    fileUploadContainer.appendChild(fileInput);
    fileUploadContainer.appendChild(customButton);
    fileUploadContainer.appendChild(this.fileNameLabel);

    // append all elements to the root element
    this.rootElement.appendChild(videoUrlContainer);
    this.rootElement.appendChild(isVimeoContainer);
    this.rootElement.appendChild(orLabel);
    this.rootElement.appendChild(fileUploadContainer);

    // Set the position
    if (referencePosition?.rect) {
      const bottom = referencePosition.rect.top + referencePosition.rect.height;
      const containerHeight = container.getBoundingClientRect().height;
      const displayAbove = bottom +40 > containerHeight;

      this.adjustPosition(this.rootElement, referencePosition.rect, displayAbove);
    }

    // Add event listener to the custom button to trigger the file input click
    customButton.addEventListener('click', () => {
      fileInput.click();
      //customButton.style.display = 'none';
    });

    fileInput.addEventListener('change', (event) => {
      const file = (event.target as HTMLInputElement).files?.[0];
      console.log("in file event handler: ", file);

      if (file) {
        this.fileNameLabel.textContent = file.name;

        this.returnValue.type = 'file';
        this.returnValue.file = file;
        this.returnValue.video = file.name;
        this.returnValue.fileType = file.type;
        this.returnValue.is_vimeo = false;
      }
    });

    // Add event listener to the video URL input to update the value
    videoUrlInput.addEventListener('input', (event) => {
      const value = (event.target as HTMLInputElement).value;
      this.returnValue.type = 'url';
      this.returnValue.video = videoUrlInput.value;
    });

    isVimeoCheckbox.addEventListener('change', (event) => {
      const value = (event.target as HTMLInputElement).checked;
      this.returnValue.is_vimeo = isVimeoCheckbox.checked;
    });
  }

  adjustPosition(control: any, rect: any, displayAbove: boolean) {
    if (displayAbove) 
      control.style.top = (rect.top - 16) + 'px';
    else
      control.style.top = (rect.top - 4)+ 'px';
    control.style.left = (rect.left -4) + 'px';
    control.style.width = (rect.width +8) + 'px';
    control.style.height = (rect.height) + 'px;'
  }

  getValue() {
    console.log("in getValue: ", this.returnValue, this.initialValue);
    return this.returnValue || this.initialValue;
  }

  onEnd() {
    //this.container.removeChild(this.element);
    this.container.removeChild(this.rootElement);

  }

  isEditorElement(target: any) {
    if (target === this.rootElement || this.rootElement.contains(target)) {
      return true;
    }
    return false;
  }
}
