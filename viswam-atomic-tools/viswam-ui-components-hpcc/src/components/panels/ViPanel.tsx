import React, { type ReactNode } from "react";
import "@lumino/widgets/style/index.css"
import "./ViPanel.css";

// Generic wrapper for a single panel
export interface ViPanelProps extends React.HTMLAttributes<HTMLDivElement> {
  id?: string;
  key?: string;
  label?: string;
  mode?: string;
  refPanel?: string;
  caption?: string;
  closable?: boolean;
  children?: ReactNode;
  className?: string;
  style?: React.CSSProperties;
}

export const ViPanel: React.FC<ViPanelProps> = ({
  id,
  label,
  mode,
  refPanel,
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
      data-ref={refPanel}
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
