import React, { type ReactNode } from "react";
import "@lumino/widgets/style/index.css"
import "./ViWidget.css";

// Generic wrapper for a single panel
export interface ViWidgetProps extends React.HTMLAttributes<HTMLDivElement> {
  id?: string;
  key?: string;
  label?: string;
  mode?: string;
  refWidget?: string;
  caption?: string;
  closable?: boolean;
  children?: ReactNode;
  className?: string;
  style?: React.CSSProperties;
}

export const ViWidget: React.FC<ViWidgetProps> = ({
  id,
  label,
  mode,
  refWidget,
  caption,
  closable,
  children,
  className,
  style,
  ...rest
}) => {
  return (
    <div
      id={id}
      data-label={label}
      data-mode={mode}
      data-ref={refWidget}
      data-caption={caption}
      data-closable={closable ? "true" : undefined}
      className={`${className || ''}`}
      style={style || { width: "100%", height: "100%" }}
      {...rest}
    >
      {children}
    </div>
  );
};
