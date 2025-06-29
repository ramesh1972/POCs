import React, { type ReactNode, useEffect, useRef } from "react";
import "@hpcc-js/wc-layout";
import "./ViPanel.css";

export interface ViContainerPanelProps extends React.HTMLAttributes<HTMLDivElement> {
  id?: string;
  key?: string;
  title?: string;
  children?: ReactNode;
  className?: string;
  style?: React.CSSProperties;
}

/**
 * ViContainerPanel is a root container for Vi* panels (ViPanel, ViSplitPanel, ViTabPanel, ViZoomPanel, etc.).
 * It renders its children directly inside <hpcc-dockpanel> for full layout flexibility.
 */
export const ViContainerPanel: React.FC<ViContainerPanelProps> = ({
  id,
  key,
  style,
  className,
  title,

  children,
  ...rest
}) => {
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const dockPanel = ref.current?.querySelector("hpcc-dockpanel");
    if (dockPanel) {
      const handler = (evt: CustomEvent) => {
        if (!window.confirm(`Close Tab "${evt.detail.tagName} #${evt.detail.id}"?`)) {
          evt.preventDefault();
        }
      };
      dockPanel.addEventListener("closeRequest", handler as EventListener);
      return () => dockPanel.removeEventListener("closeRequest", handler as EventListener);
    }
  }, []);

  return (
    <div id={id} key={key} style={style || { width: "100%", height: "100%" }} className={className} {...rest}>
      {title && <h1>{title}</h1>}
      <div
        ref={ref}
      >
        {children}
      </div>
    </div>
  );
};

export default ViContainerPanel;
