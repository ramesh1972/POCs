export class DataGridFileUploadEditor {
    constructor(editorConfig: any, buttonText: string) {
      this.editorConfig = editorConfig;
      this.buttonText = buttonText;
    }
  
    editorConfig: any = {};
    buttonText: string = '';
    container: any;
    successCallback: any;
    element: any;
    initialValue: any;
    returnValue: any;
    customButton: any;
  
    onStart({ container, referencePosition, value, endEdit }: any) {
      console.log("in onStart: ", container, referencePosition, value, endEdit);
      const that = this;
      this.container = container;
      this.successCallback = endEdit;
      const input = document.createElement('input');
  
      input.setAttribute('type', 'file');
      input.style.display = 'none';
  
      const customButton = document.createElement('button');
      customButton.textContent = this.buttonText || 'Upload File';
      customButton.style.padding = '6px';
      customButton.style.background = 'linear-gradient(to bottom, #4A90E2, #007AFF, #4A90E2)'; // Blue gradient
      customButton.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.3), 0 1px 3px rgba(0, 0, 0, 0.08)'; // Shadow
      customButton.style.textShadow = '1px 1px 2px rgba(0, 0, 0, 0.5)'; // Projected text effect
      customButton.style.color = 'white';
      customButton.style.border = '1px solid grey';
      customButton.style.borderBottomLeftRadius = '8px';
      customButton.style.borderBottomRightRadius = '8px';
      customButton.style.cursor = 'pointer';
      customButton.style.position = 'absolute';
      customButton.style.width = '160px';
      customButton.style.height = '40px';
  
      this.customButton = customButton;
      input.value = '';
      this.initialValue = value; // Store the initial value
      this.element = input;
      container.appendChild(input);
      container.appendChild(customButton);
  
      if (referencePosition?.rect) {
        const bottom = referencePosition.rect.top + referencePosition.rect.height;
        const containerHeight = container.getBoundingClientRect().height;
        const displayAbove = bottom +40 > containerHeight;

        this.adjustPosition(referencePosition.rect, displayAbove);
      }
  
      // Add event listener to the custom button to trigger the file input click
      customButton.addEventListener('click', () => {
        input.click();
        customButton.style.display = 'none';
      });
  
      input.addEventListener('change', (event) => {
        const file = (event.target as HTMLInputElement).files?.[0];
        console.log("in file event handler: ", file);
  
        if (file) {
          that.returnValue = {
            file: file,
            fileName: file.name,
            fileType: file.type,
          };
        } else {
          that.returnValue = null;
        }
      });
    }
  
    adjustPosition(rect: any, displayAbove: boolean) {  
      if (displayAbove) {
        this.customButton.style.top = rect.top - 40 + 'px';
        this.customButton.style.left = rect.left + 'px';
        return;
      }
      
      this.customButton.style.top = rect.top + rect.height + 'px';
      this.customButton.style.left = rect.left + 'px';
    }
  
    getValue() {
      return this.returnValue || this.initialValue;
    }
  
    onEnd() {
      this.container.removeChild(this.element);
      this.container.removeChild(this.customButton);
  
    }
  
    isEditorElement(target: any) {
      if (target === this.customButton) {
        return true;
      }
      return false;
    }
  }
  