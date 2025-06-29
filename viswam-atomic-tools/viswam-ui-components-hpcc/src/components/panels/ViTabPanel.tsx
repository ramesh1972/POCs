import React from "react";
import type { ViPanelProps } from "./ViPanel";
import "@hpcc-js/wc-layout";

export interface ViTabPanelProps extends ViPanelProps {
    addButtonEnabled?: boolean; // Default to false
    tab_placement?: "top" | "bottom" | "left" | "right"; // Default to top placement
    tabsMovable?: boolean; // Default to not movable
};

/**
 * ViTabPanel is a React wrapper for the <hpcc-tabpanel> web component.
 * Children should be provided in pairs: [<div slot="tab-title">...</div>, <div>...</div>, ...]
 */
export const ViTabPanel: React.FC<ViTabPanelProps> = ({
    id,
    key,
    label,
    addButtonEnabled = false, // Default to false
    tab_placement = "top", // Default to top placement
    tabsMovable = false, // Default to not movable
    children,
    style,
    className,
    ...rest
}) => {
    return (
        <div id={id} key={key}
            style={style || { width: "100%", height: "100%" }}
            className={className}
            {...rest}
        >
            <hpcc-tabpanel
                add_button_enabled={addButtonEnabled} /* ToDo check if this works */
                tab_placement={tab_placement} /* ToDo check if this works for left and right */
                tabs_movable={tabsMovable}
                data_label={label} /* ToDo check if this works for left and right */
                style={style || { width: "100%", height: "100%" }}
           >
                {children}
            </hpcc-tabpanel>
        </div>
    );
};

export default ViTabPanel;
