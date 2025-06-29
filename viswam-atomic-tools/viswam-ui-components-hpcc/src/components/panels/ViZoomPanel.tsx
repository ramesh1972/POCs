import React from "react";
import type { ViPanelProps } from "./ViPanel";
import "@hpcc-js/wc-layout";

export interface ViZoomPanelProps extends ViPanelProps {
    x?: number;
    y?: number;
    scale?: number;
    scale_max?: number;
    scale_min?: number;
}

/**
 * ViZoomPanel is a React wrapper for the <hpcc-zoom> web component.
 */
export const ViZoomPanel: React.FC<ViZoomPanelProps> = ({
    id,
    key,
    x = 10,
    y = 10,
    scale = 0.63,
    scale_max = 10,
    scale_min = 0.01,
    style,
    className,
    children,
    ...rest
}) => (
    <div id={id} key={key}
        style={style || { width: "100%", height: "500px" }}
        className={className}
        {...rest}
    >
        <hpcc-zoom
            x={x}
            y={y}
            scale={scale}
            data-scale_max={scale_max} /* ToDO check if this works */
            data-scale_min={scale_min}
            style={ style || { width: "100%", height: "500px" }}
            className={className}
        >
            {children}
        </hpcc-zoom>
    </div>
);

export default ViZoomPanel;
