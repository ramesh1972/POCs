export class DataGridDropDownEditor {
  constructor(editorConfig: any) {
    this.editorConfig = editorConfig;
  }

  editorConfig: any = {};
  container: any;
  successCallback: any;
  dropdown: any;
  initialValue: any;
  returnValue: any;

  onStart({ container, referencePosition, value, endEdit }: any) {
    console.log("in onStart: ", container, referencePosition, value, endEdit);
    const that = this;
    this.container = container;
    this.successCallback = endEdit;
    this.initialValue = value; // Store the initial value

    // Create the dropdown element
    this.dropdown = document.createElement('select');
    this.dropdown.style.position = 'absolute';
    this.dropdown.style.padding = '6px';
    this.dropdown.style.background = 'linear-gradient(to bottom, #4290E2, #087AFF, #4290E2)'; // Blue gradient
    this.dropdown.style.boxShadow = '0 0.625em 1em 0 rgba(30, 143, 255, 0.35)'; // Shadow
    this.dropdown.style.border = '1px solid grey';
    this.dropdown.style.textShadow = '1px 1px 2px rgba(0, 0, 0, 0.5)'; // Projected text effect

    // Populate the dropdown with options
    const options = this.editorConfig.options || [];
    options.forEach((opt: any) => {
      const option = document.createElement('option');
      option.value = opt.value;
      option.textContent = opt.label;

      option.style.padding = '4px';
      option.style.backgroundColor = 'lightyellow'; // Yellow background
      option.style.textShadow = '1px 1px 2px rgba(0, 0, 0, 0.5)'; // Projected text effect
    


      if (value && value.value === opt.value) {
        option.selected = true;
      }

      this.dropdown.appendChild(option);
    });

    // Append the dropdown to the container
    container.appendChild(this.dropdown);

    setTimeout(() => {
      this.dropdown.dispatchEvent(new MouseEvent('mousedown', { bubbles: true, cancelable: true }));
    }, 0);

    // Handle dropdown change event
    this.dropdown.addEventListener('change', (event:any) => {
      var val = (event.target as HTMLSelectElement).value;
      var label = (event.target as HTMLSelectElement).selectedOptions[0].textContent;

      this.returnValue = { value: val, label: label };
      console.log("Selected value: ", this.returnValue);
    });

    if (referencePosition?.rect) {
        const bottom = referencePosition.rect.top + referencePosition.rect.height;
        const containerHeight = container.getBoundingClientRect().height;
        const displayAbove = bottom + 40 > containerHeight;

      this.adjustPosition(referencePosition.rect, displayAbove);
    }
  }

  adjustPosition(rect: any, displayAbove: boolean) {
    this.dropdown.style.top = rect.top + 'px';
    this.dropdown.style.left = rect.left + 'px';
    this.dropdown.style.width = rect.width + 'px';
    this.dropdown.style.height = rect.height + 'px';
    this.dropdown.style.zIndex = '1000';
  }

  getValue() {
    return this.returnValue || this.initialValue;
  }

  onEnd() {
    this.container.removeChild(this.dropdown);
  }

  isEditorElement(target: any) {
    if (target === this.dropdown) {
      return true;
    }
    return false;
  }
}
