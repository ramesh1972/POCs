// Custom JSX types for HPCC dockpanel web component
import type * as React from "react";

declare module "react" {
  namespace JSX {
    interface IntrinsicElements {
      "hpcc-dockpanel": React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
      "hpcc-tabpanel": React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement> & {
        add_button_enabled?: boolean; // Default to false
        tab_placement?: "top" | "bottom" | "left" | "right"; // Default to top placement
        tabs_movable?: boolean; // Default to not movable
        data_label?: string; // ToDo: check if this works
      };
      "hpcc-splitpanel": React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement> & {
        orientation?: "horizontal" | "vertical";
        spacing?: number; // Not used in this implementation, but can be added if needed
        borderWidth?: number; // Not used in this implementation, but can be added if needed
        panelPadding?: number; // Not used in this implementation, but can be added if needed
      };
      "hpcc-zoom": React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>  & {
        x?: number;
        y?: number;
        scale?: number;
        scale_max?: number; // ToDo: check if this works
        scale_min?: number; // ToDo: check if this works
      };
    }
  }
}
