import React from "react";
import type { ViPanelProps } from "./ViPanel";
import "@hpcc-js/wc-layout";

export interface ViDockPanelProps extends ViPanelProps {
  title?: string;
}

export const ViDockPanel: React.FC<ViDockPanelProps> = ({
  id,
  key,
  style,
  className,
  title,
  children,
  ...rest
}) => (
  <div
    id={id}
    key={key}
    style={style || { width: "100%", height: "100%" }}
    className={className}
    {...rest}
  >
    {title && <h1>{title}</h1>}
    <hpcc-dockpanel style={style || { width: "100%", height: "100%" }}>
      {children}
    </hpcc-dockpanel>
  </div>
);

export default ViDockPanel;
