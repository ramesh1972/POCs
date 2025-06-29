import React from "react";
import type { ViPanelProps } from "./ViPanel";
import "@hpcc-js/wc-layout";

export interface ViSplitPanelProps extends ViPanelProps {
    orientation?: "horizontal" | "vertical";
    spacing?: number; // Not used in this implementation, but can be added if needed
    borderWidth?: number; // Not used in this implementation, but can be added if needed
    panelPadding?: number; // Not used in this implementation, but can be added if needed
}

export const ViSplitPanel: React.FC<ViSplitPanelProps> = ({
    id,
    key,
    orientation = "horizontal",
    spacing = 0, // Default spacing
    borderWidth = 0, // Default border width
    panelPadding = 0, // Default panel padding
    style,
    className,
    children,
    ...rest
}) => (
    <div id={id} key={key}
        style={style || { }}
        className={className}
        {...rest}
    >
        <hpcc-splitpanel
            orientation={orientation}
            spacing={spacing} 
            data-border-width={borderWidth} /* TODO no effect */
            data-padding={panelPadding} /* TODO no effect */
            style={style || { } }
        >
            {children}
        </hpcc-splitpanel>
    </div>
);

export default ViSplitPanel;
