/* eslint-disable @typescript-eslint/no-explicit-any */
import React from "react";
import $ from 'jquery';
(window as any).jQuery = $;
(window as any).$ = $;
import 'jquery-ui-dist/jquery-ui';
import 'jquery-ui-dist/jquery-ui.css';

import 'dsmorse-gridster/dist/jquery.gridster.css';
import 'dsmorse-gridster/dist/jquery.dsmorse-gridster.min.js';
import './assets/less/demo.less';

// Extend JQuery type definitions to include gridster
declare global {
    interface JQuery {
        gridster(options?: any): any;
    }
}

const widgets = [
    ['<li>0</li>', 1, 2],
    ['<li>1</li>', 3, 2],
    ['<li>2</li>', 3, 2],
    ['<li>3</li>', 2, 1],
    ['<li>4</li>', 4, 1],
    ['<li>5</li>', 1, 2],
    ['<li>6</li>', 2, 1],
    ['<li>7</li>', 3, 2],
    ['<li>8</li>', 1, 1],
    ['<li>9</li>', 2, 2],
    ['<li>10</li>', 1, 3]
];

// same object than generated with gridster.serialize() method
const serialization = [
    { col: 1, row: 1, size_x: 2, size_y: 2 },
    { col: 3, row: 1, size_x: 1, size_y: 2 },
    { col: 4, row: 1, size_x: 1, size_y: 1 },
    { col: 2, row: 3, size_x: 3, size_y: 1 },
    { col: 1, row: 4, size_x: 1, size_y: 1 },
    { col: 1, row: 3, size_x: 1, size_y: 1 },
    { col: 2, row: 4, size_x: 1, size_y: 1 },
    { col: 2, row: 5, size_x: 1, size_y: 1 }
];

const LayoutGrid: React.FC<any> = () => {
    const gridsterRef = React.useRef<any>(null);
    const [resizeEnabled, setResizeEnabled] = React.useState(false);

    React.useEffect(() => {
        const gridster2 = $(".gridster > ul").gridster({
            widget_margins: [10, 10],
            widget_base_dimensions: [100, 100],
                        shift_widgets_up: false,
            shift_larger_widgets_down: false,
            draggable: {
                start: function (event: any, ui: any) {
                    console.log("Drag started", event, ui);
                },
                stop: function (event: any, ui: any) {
                    console.log("Drag stopped", event, ui);
                }
            },
            resize: {
                enabled: true
            },
        }).data('gridster');

        if (!gridster2) {
            console.error("Gridster initialization failed.");
            return;
        }

        gridsterRef.current = gridster2;

        $.each(widgets, function (_i, widget) {
            gridster2.add_widget(...widget);
        });

        $(".gridster").on('mouseenter', 'li', function () {
            if (!resizeEnabled) return;
            gridster2.resize_widget($(this), 3, 3);
        });

        $(".gridster").on('mouseleave', 'li', function () {
            if (!resizeEnabled) return;
            gridster2.resize_widget($(this), 1, 1);
        });

        return () => {
            gridster2.remove_all_widgets();
            gridster2.destroy();
        };
    }, [resizeEnabled]);

    // Handler to load from serialization
    const handleLoadFromSerialization = () => {
        if (!gridsterRef.current) return;
        gridsterRef.current.remove_all_widgets();
        serialization.forEach((item, idx) => {
            gridsterRef.current.add_widget(`<li>${idx}</li>`, item.size_x, item.size_y, item.col, item.row);
        });
    };

    // Handler to save current layout to localStorage
    const handleSaveLayout = () => {
        if (!gridsterRef.current) return;
        const serialized = gridsterRef.current.serialize();
        localStorage.setItem('gridsterLayout', JSON.stringify(serialized));
    };

    // Handler to load layout from localStorage
    const handleLoadLayout = () => {
        if (!gridsterRef.current) return;
        const saved = localStorage.getItem('gridsterLayout');
        console.log("Saved layout:", saved);
        if (!saved) return;
        const layout = JSON.parse(saved);
        gridsterRef.current.remove_all_widgets();
        layout.forEach((item: any, idx: number) => {
            // item is an array of objects, get the first object
            const w = item;
            gridsterRef.current.add_widget(`<li>${idx}</li>`, w.size_x, w.size_y, w.col, w.row);
        });
    };

    // Handler for resize checkbox
    const handleResizeCheckbox = (e: React.ChangeEvent<HTMLInputElement>) => {
        setResizeEnabled(e.target.checked);
    };

    return (
        <div style={{ width: '100vw', height: '100vh', display: 'flex', flexDirection: 'column' }}>
            <div style={{ padding: '10px', flex: '0 0 auto', background: 'transparent' }}>
                <label style={{ marginRight: '20px' }}>
                    <input type="checkbox" checked={resizeEnabled} onChange={handleResizeCheckbox} /> Enable Resize
                </label>
                <button onClick={handleLoadFromSerialization} style={{ marginRight: '10px' }}>Load from Serialization</button>
                <button onClick={handleSaveLayout} style={{ marginRight: '10px' }}>Save Layout</button>
                <button onClick={handleLoadLayout} style={{ marginRight: '10px' }}>Load Layout</button>
            </div>
            <div style={{ flex: '1 1 0', minHeight: 0, minWidth: 0, overflow: 'hidden', display: 'flex' }}>
                <div className="gridster" style={{ width: '100%', height: '100%', backgroundColor: 'yellow', padding: 0, margin: 0, display: 'block', overflow: 'hidden' }}>
                    <ul style={{ width: '100%', height: '100%', minHeight: '100%', minWidth: '100%', backgroundColor: 'blue', margin: 0, padding: 0 }}></ul>
                </div>
            </div>
        </div>
    );
};

export default LayoutGrid;