import React, { useEffect, useRef, useState } from "react";
import {
  GoldenLayout,
  ComponentContainer,
  ComponentItemConfig,
  ContentItem,
  EventEmitter,
  JsonValue,
  LayoutConfig,
  LogicalZIndex,
  ResolvedComponentItemConfig,
  ResolvedLayoutConfig,
  Stack
} from "golden-layout";
import { BooleanComponent } from "./boolean-component";
import { ColorComponent } from "./color-component";
import { EventComponent } from "./event-component";
import { prefinedLayouts } from "./predefined-layouts";
import { TextComponent } from "./text-component";
import "golden-layout/dist/css/goldenlayout-base.css";
import "golden-layout/dist/css/themes/goldenlayout-light-theme.css";
import "./styles.css";
const GoldenPanel: React.FC = () => {
  const controlsRef = useRef<HTMLElement>(null);
  const layoutRef = useRef<HTMLElement>(null);
  const [goldenLayout, setGoldenLayout] = useState<GoldenLayout | null>(null);
  const [allComponentsRegistered, setAllComponentsRegistered] = useState(false);
  const [useVirtualEventBinding, setUseVirtualEventBinding] = useState(true);
  const [savedLayout, setSavedLayout] = useState<ResolvedLayoutConfig | undefined>(undefined);
  const [bubbleClickCount, setBubbleClickCount] = useState(0);
  const [captureClickCount, setCaptureClickCount] = useState(0);
  const [lastVirtualRectingCount, setLastVirtualRectingCount] = useState(0);
  const [stackHeaderClickedCount, setStackHeaderClickedCount] = useState(0);
  const [showStackHeaderClicked, setShowStackHeaderClicked] = useState(false);
  const boundComponentMap = useRef(new Map<ComponentContainer, any>()).current;
  const goldenLayoutBoundingClientRect = useRef<DOMRect>(new DOMRect());

  // Refs for controls
  const registeredComponentTypesForAddSelect = useRef<HTMLSelectElement>(null);
  const registeredComponentTypesForReplaceSelect = useRef<HTMLSelectElement>(null);
  const layoutSelect = useRef<HTMLSelectElement>(null);
  const reloadSavedLayoutButton = useRef<HTMLButtonElement>(null);
  const lastVirtualRectingCountSpan = useRef<HTMLSpanElement>(null);
  const bubbleClickCountSpan = useRef<HTMLSpanElement>(null);
  const captureClickCountSpan = useRef<HTMLSpanElement>(null);
  const stackHeaderClickedDiv = useRef<HTMLDivElement>(null);
  const stackHeaderClickedItemCountSpan = useRef<HTMLSpanElement>(null);

  // GoldenLayout instance ref for full destroy/recreate
  const goldenLayoutInstanceRef = useRef<GoldenLayout | null>(null);

  // Helper: get all component type names
  const getAllComponentTypeNames = () => [
    ColorComponent.typeName,
    TextComponent.typeName,
    BooleanComponent.typeName,
    EventComponent.typeName
  ];

  // Helper: create component
  const createComponent = (
    container: ComponentContainer,
    componentTypeName: string,
    state: JsonValue | undefined,
    virtual: boolean
  ) => {
    switch (componentTypeName) {
      case ColorComponent.typeName:
        return new ColorComponent(container, state, virtual);
      case TextComponent.typeName:
        return new TextComponent(container, state, virtual);
      case BooleanComponent.typeName:
        return new BooleanComponent(container, state, virtual);
      case EventComponent.typeName:
        return new EventComponent(container, state, virtual);
      default:
        throw new Error("createComponent: Unexpected componentTypeName: " + componentTypeName);
    }
  };

  // GoldenLayout event handlers
  const handleBindComponentEvent = (
    container: ComponentContainer,
    itemConfig: ResolvedComponentItemConfig
  ) => {
    const componentTypeName = ResolvedComponentItemConfig.resolveComponentTypeName(itemConfig);
    if (componentTypeName === undefined) {
      throw new Error("handleBindComponentEvent: Undefined componentTypeName");
    }
    const component = createComponent(
      container,
      componentTypeName,
      itemConfig.componentState,
      useVirtualEventBinding
    );
    boundComponentMap.set(container, component);
    if (useVirtualEventBinding && layoutRef.current) {
      const componentRootElement = component.rootHtmlElement;
      layoutRef.current.appendChild(componentRootElement);
      container.virtualRectingRequiredEvent = (container, width, height) =>
        handleContainerVirtualRectingRequiredEvent(container, width, height);
      container.virtualVisibilityChangeRequiredEvent = (container, visible) =>
        handleContainerVirtualVisibilityChangeRequiredEvent(container, visible);
      container.virtualZIndexChangeRequiredEvent = (container, logicalZIndex, defaultZIndex) =>
        handleContainerVirtualZIndexChangeRequiredEvent(container, logicalZIndex, defaultZIndex);
      return { component, virtual: true };
    } else {
      return { component, virtual: false };
    }
  };

  const handleUnbindComponentEvent = (container: ComponentContainer) => {
    const component = boundComponentMap.get(container);
    if (!component) throw new Error("handleUnbindComponentEvent: Component not found");
    const componentRootElement = component.rootHtmlElement;
    if (!componentRootElement) throw new Error("handleUnbindComponentEvent: Component does not have a root HTML element");
    if (container.virtual && layoutRef.current) {
      layoutRef.current.removeChild(componentRootElement);
    }
    boundComponentMap.delete(container);
  };

  const handleBeforeVirtualRectingEvent = (count: number) => {
    if (layoutRef.current) {
      goldenLayoutBoundingClientRect.current = layoutRef.current.getBoundingClientRect();
      setLastVirtualRectingCount(count);
    }
  };

  const handleContainerVirtualRectingRequiredEvent = (
    container: ComponentContainer,
    width: number,
    height: number
  ) => {
    const component = boundComponentMap.get(container);
    if (!component) throw new Error("handleContainerVirtualRectingRequiredEvent: Component not found");
    const rootElement = component.rootHtmlElement;
    if (!rootElement) throw new Error("handleContainerVirtualRectingRequiredEvent: Component does not have a root HTML element");
    const containerBoundingClientRect = container.element.getBoundingClientRect();
    const left = containerBoundingClientRect.left - goldenLayoutBoundingClientRect.current.left;
    rootElement.style.left = `${left}px`;
    const top = containerBoundingClientRect.top - goldenLayoutBoundingClientRect.current.top;
    rootElement.style.top = `${top}px`;
    rootElement.style.width = `${width}px`;
    rootElement.style.height = `${height}px`;
  };

  const handleContainerVirtualVisibilityChangeRequiredEvent = (
    container: ComponentContainer,
    visible: boolean
  ) => {
    const component = boundComponentMap.get(container);
    if (!component) throw new Error("handleContainerVisibilityChangeRequiredEvent: Component not found");
    const componentRootElement = component.rootHtmlElement;
    if (!componentRootElement) throw new Error("handleContainerVisibilityChangeRequiredEvent: Component does not have a root HTML element");
    componentRootElement.style.display = visible ? "" : "none";
  };

  const handleContainerVirtualZIndexChangeRequiredEvent = (
    container: ComponentContainer,
    logicalZIndex: LogicalZIndex,
    defaultZIndex: string
  ) => {
    const component = boundComponentMap.get(container);
    if (!component) throw new Error("handleContainerVirtualZIndexChangeRequiredEvent: Component not found");
    const componentRootElement = component.rootHtmlElement;
    if (!componentRootElement) throw new Error("handleContainerVirtualZIndexChangeRequiredEvent: Component does not have a root HTML element");
    componentRootElement.style.zIndex = defaultZIndex;
  };

  // UI event handlers
  const handleRegisterComponentTypes = () => {
    if (!goldenLayout || allComponentsRegistered) return;
    goldenLayout.registerComponentConstructor(ColorComponent.typeName, ColorComponent);
    goldenLayout.registerComponentConstructor(EventComponent.typeName, EventComponent);
    setAllComponentsRegistered(true);
    // ...disable UI as needed
  };

  const handleRegisterComponentTypesAsVirtual = () => {
    if (!goldenLayout || allComponentsRegistered) return;
    goldenLayout.registerComponentConstructor(TextComponent.typeName, TextComponent, true);
    goldenLayout.registerComponentConstructor(BooleanComponent.typeName, BooleanComponent, true);
    setAllComponentsRegistered(true);
    // ...disable UI as needed
  };

  const handleEventBindingVirtualRadioClick = () => {
    goldenLayout?.clear();
    setUseVirtualEventBinding(true);
  };

  const handleEventBindingEmbeddedRadioClick = () => {
    goldenLayout?.clear();
    setUseVirtualEventBinding(false);
  };

  const handleClearButtonClick = () => {
    goldenLayout?.clear();
  };

  const handleAddComponentButtonClick = () => {
    if (!goldenLayout || !registeredComponentTypesForAddSelect.current) return;
    const componentType = registeredComponentTypesForAddSelect.current.value;
    goldenLayout.addComponent(componentType);
  };

  const handleLoadLayoutButtonClick = () => {
    if (!layoutSelect.current) return;
    const layoutName = layoutSelect.current.value;
    const layouts = prefinedLayouts.allComponents;
    const selectedLayout = layouts.find((layout) => layout.name === layoutName);
    if (!selectedLayout) return;
    destroyGoldenLayout();
    const gl = createGoldenLayout();
    if (!gl) return;
    gl.registerComponentConstructor(ColorComponent.typeName, ColorComponent);
    gl.registerComponentConstructor(EventComponent.typeName, EventComponent);
    setAllComponentsRegistered(true);
    gl.loadLayout(selectedLayout.config);
  };

  const handleLoadComponentAsRootButtonClick = () => {
    if (!goldenLayout) return;
    const itemConfig: ComponentItemConfig = {
      type: "component",
      componentType: ColorComponent.typeName,
      componentState: "yellow"
    };
    goldenLayout.loadComponentAsRoot(itemConfig);
  };

  const handleReplaceComponentButtonClick = () => {
    if (!goldenLayout || !registeredComponentTypesForReplaceSelect.current) return;
    const componentType = registeredComponentTypesForReplaceSelect.current.value;
    const itemConfig: ComponentItemConfig = {
      componentType,
      type: "component"
    };
    const rootItem = goldenLayout.rootItem;
    if (rootItem) {
      replaceComponentRecursively([rootItem], itemConfig);
    }
  };

  const handleSaveLayoutButtonClick = () => {
    if (!goldenLayout) return;
    setSavedLayout(goldenLayout.saveLayout());
    if (reloadSavedLayoutButton.current) reloadSavedLayoutButton.current.disabled = false;
  };

  const handleReloadSavedLayoutButtonClick = () => {
    if (!goldenLayout || !savedLayout) return;
    const layoutConfig = LayoutConfig.fromResolved(savedLayout);
    goldenLayout.loadLayout(layoutConfig);
  };

  const replaceComponentRecursively = (content: ContentItem[], itemConfig: ComponentItemConfig) => {
    for (const item of content) {
      if (ContentItem.isComponentItem(item)) {
        const container = item.container;
        if (container.componentType === ColorComponent.typeName) {
          container.replaceComponent(itemConfig);
        }
      } else {
        replaceComponentRecursively(item.contentItems, itemConfig);
      }
    }
  };

  // Helper: destroy GoldenLayout instance
  const destroyGoldenLayout = () => {
    if (goldenLayoutInstanceRef.current) {
      goldenLayoutInstanceRef.current.destroy();
      goldenLayoutInstanceRef.current = null;
      setGoldenLayout(null);
      setAllComponentsRegistered(false);
      // Remove all children from layoutRef
      if (layoutRef.current) {
        while (layoutRef.current.firstChild) {
          layoutRef.current.removeChild(layoutRef.current.firstChild);
        }
      }
    }
  };

  // Helper: create and set up GoldenLayout instance
  const createGoldenLayout = () => {
    if (!layoutRef.current) return null;
    const gl = new GoldenLayout(
      layoutRef.current,
      handleBindComponentEvent,
      handleUnbindComponentEvent
    );
    gl.resizeWithContainerAutomatically = true;
    gl.beforeVirtualRectingEvent = (count) => handleBeforeVirtualRectingEvent(count);
    gl.addEventListener("stackHeaderClick", (event: any) => {
      const stack = event.target as Stack;
      setStackHeaderClickedCount(stack.contentItems.length);
      setShowStackHeaderClicked(true);
      setTimeout(() => setShowStackHeaderClicked(false), 1000);
    });
    setGoldenLayout(gl);
    goldenLayoutInstanceRef.current = gl;
    return gl;
  };

  // Replace GoldenLayout setup on mount
  useEffect(() => {
    destroyGoldenLayout();
    const gl = createGoldenLayout();
    if (!gl) return;
    gl.registerComponentConstructor(ColorComponent.typeName, ColorComponent);
    gl.registerComponentConstructor(EventComponent.typeName, EventComponent);
    setAllComponentsRegistered(true);
    if (prefinedLayouts.allComponents && prefinedLayouts.allComponents.length > 0) {
      gl.loadLayout(prefinedLayouts.allComponents[0].config);
    }
    // On unmount: destroy GoldenLayout
    return () => {
      destroyGoldenLayout();
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Populate selects after mount
  useEffect(() => {
    if (registeredComponentTypesForAddSelect.current) {
      registeredComponentTypesForAddSelect.current.options.length = 0;
      getAllComponentTypeNames().forEach((name) => {
        registeredComponentTypesForAddSelect.current?.options.add(new Option(name));
      });
    }
    if (registeredComponentTypesForReplaceSelect.current) {
      registeredComponentTypesForReplaceSelect.current.options.length = 0;
      getAllComponentTypeNames().forEach((name) => {
        registeredComponentTypesForReplaceSelect.current?.options.add(new Option(name));
      });
    }
    if (layoutSelect.current) {
      layoutSelect.current.options.length = 0;
      prefinedLayouts.allComponents.forEach((layout) => {
        layoutSelect.current?.options.add(new Option(layout.name));
      });
    }
  }, [goldenLayout]);

  // Click count handlers
  useEffect(() => {
    const bubbleHandler = () => setBubbleClickCount((c) => c + 1);
    const captureHandler = () => setCaptureClickCount((c) => c + 1);
    window.addEventListener("click", bubbleHandler, { passive: true });
    window.addEventListener("click", captureHandler, { capture: true, passive: true });
    return () => {
      window.removeEventListener("click", bubbleHandler);
      window.removeEventListener("click", captureHandler);
    };
  }, []);

  // Update spans
  useEffect(() => {
    if (lastVirtualRectingCountSpan.current)
      lastVirtualRectingCountSpan.current.innerText = lastVirtualRectingCount.toString();
    if (bubbleClickCountSpan.current)
      bubbleClickCountSpan.current.innerText = bubbleClickCount.toString();
    if (captureClickCountSpan.current)
      captureClickCountSpan.current.innerText = captureClickCount.toString();
    if (stackHeaderClickedItemCountSpan.current)
      stackHeaderClickedItemCountSpan.current.innerText = stackHeaderClickedCount.toString();
    if (stackHeaderClickedDiv.current)
      stackHeaderClickedDiv.current.style.display = showStackHeaderClicked ? "" : "none";
  }, [lastVirtualRectingCount, bubbleClickCount, captureClickCount, stackHeaderClickedCount, showStackHeaderClicked]);

  return (
    <section id="bodySection">
      <section id="controls" ref={controlsRef as any}>
        <section id="registerSection">
          <section id="registerNotVirtualSection">
            <button id="registerNotVirtualButton" className="control" onClick={handleRegisterComponentTypes}>
              Register Component Types
            </button>
            <section id="registerNotVirtualRadioSection" className="radioLine">
              <section className="labelledRadio">
                <input id="registerNotVirtualAllRadio" className="control" type="radio" name="registerNotVirtualRadio" />
                <label htmlFor="registerNotVirtualAllRadio">All</label>
              </section>
              <section className="labelledRadio">
                <input id="registerNotVirtualColorEventRadio" className="control" type="radio" name="registerNotVirtualRadio" defaultChecked />
                <label htmlFor="registerNotVirtualColorEventRadio">Color, Event</label>
              </section>
            </section>
          </section>
          <section id="registerVirtualSection">
            <button id="registerVirtualButton" className="control" onClick={handleRegisterComponentTypesAsVirtual}>
              Register Component Types As Virtual
            </button>
            <section id="registerVirtualRadioSection" className="radioLine">
              <section className="labelledRadio">
                <input id="registerVirtualAllRadio" type="radio" name="registerVirtualRadio" />
                <label htmlFor="registerVirtualAllRadio">All</label>
              </section>
              <section className="labelledRadio">
                <input id="registerVirtualTextBooleanRadio" type="radio" name="registerVirtualRadio" defaultChecked />
                <label htmlFor="registerVirtualTextBooleanRadio">Text, Boolean</label>
              </section>
            </section>
          </section>
        </section>
        <section id="eventBindingSection">
          <span id="eventBindingSpan" title="Layout will be cleared">Event Binding:</span>
          <section id="eventBindingRadios" className="radioLine">
            <section className="labelledRadio">
              <input id="eventBindingVirtualRadio" className="control" type="radio" name="eventBindingRadio" title="Layout will be cleared" onClick={handleEventBindingVirtualRadioClick} />
              <label htmlFor="eventBindingVirtualRadio">Virtual</label>
            </section>
            <section className="labelledRadio">
              <input id="eventBindingEmbeddedRadio" className="control" type="radio" name="eventBindingRadio" title="Layout will be cleared" onClick={handleEventBindingEmbeddedRadioClick} />
              <label htmlFor="eventBindingEmbeddedRadio">Embedded</label>
            </section>
          </section>
        </section>
        <section id="clearSection">
          <button id="clearButton" className="control" onClick={handleClearButtonClick}>Clear</button>
        </section>
        <section id="predefinedLayoutsSection">
          <select id="layoutSelect" className="control" ref={layoutSelect}></select>
          <button id="loadLayoutButton" className="control" onClick={handleLoadLayoutButtonClick}>Load Layout</button>
        </section>
        <section id="saveAndReloadLayoutSection">
          <button id="saveLayoutButton" className="control" onClick={handleSaveLayoutButtonClick}>Save Layout</button>
          <button id="reloadSavedLayoutButton" className="control" ref={reloadSavedLayoutButton} onClick={handleReloadSavedLayoutButtonClick}>Reload saved Layout</button>
        </section>
        <section id="addComponentSection">
          <select id="registeredComponentTypesForAddSelect" className="control" ref={registeredComponentTypesForAddSelect}></select>
          <button id="addComponentByDragButton" className="control">D</button>
          <button id="addComponentButton" className="control" onClick={handleAddComponentButtonClick}>Add Component</button>
        </section>
        <section id="rootComponentSection">
          <button id="loadComponentAsRootButton" className="control" onClick={handleLoadComponentAsRootButtonClick}>Load Component as Root</button>
        </section>
        <section id="replaceComponentSection">
          <select id="registeredComponentTypesForReplaceSelect" className="control" ref={registeredComponentTypesForReplaceSelect}></select>
          <button id="replaceComponentButton" className="control" onClick={handleReplaceComponentButtonClick}>Replace Color Component with</button>
        </section>
        <section id="lastVirtualRectingCountSection">
          <span>Last virtual recting count</span>
          <span id="lastVirtualRectingCountSpan" ref={lastVirtualRectingCountSpan}></span>
        </section>
        <section id="clickCount">
          <span>Click count: Capture: </span>
          <span id="captureClickCountSpan" ref={captureClickCountSpan}></span>
          <span> Bubble: </span>
          <span id="bubbleClickCountSpan" ref={bubbleClickCountSpan}></span>
        </section>
        <section id="stackHeaderClick">
          <span>Stack Header: </span>
          <div id="stackHeaderClickedDiv" ref={stackHeaderClickedDiv}>
            <span>Clicked: </span>
            <span id="stackHeaderClickedItemCountSpan" ref={stackHeaderClickedItemCountSpan}></span>
          </div>
        </section>
      </section>
      <section id="layoutContainer" ref={layoutRef}></section>
    </section>
  );
};

export default GoldenPanel;
