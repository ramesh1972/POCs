/* eslint-disable @typescript-eslint/no-explicit-any */
import { useState, useEffect } from "react";
import { ViContainerPanel } from "../components/panels/ViContainerPanel";
import { ViPanel } from "../components/panels/ViPanel";
import { ViDockPanel } from "../components/panels/ViDockPanel";
import { ViSplitPanel } from "../components/panels/ViSplitPanel";
import { ViTabPanel } from "../components/panels/ViTabPanel";
import { ViZoomPanel } from "../components/panels/ViZoomPanel";
import { ViChartWidget } from "../components/widgets/ViChartWidget";
import { defaultChartData } from "../components/widgets/ViChartDefaults";
import Button from "@mui/material/Button";
import AddIcon from "@mui/icons-material/Add";

const randomContent = () => {
    const n = Math.floor(Math.random() * 10000);
    return (
        <>
            <h2>Random Panel #{n}</h2>
            <p>Lorem ipsum dolor sit amet, panel id: {n}</p>
        </>
    );
};

const panelStyle = {
    color: "#222",
    fontFamily: "'Segoe UI', 'Roboto', 'Arial', sans-serif",
    fontWeight: 500,
    fontSize: "1.1rem",
    cursor: "pointer",
    minWidth: 48,
    overflow: "auto",
    padding: 8,
    margin: 0
};

// Helper to get panel content by key
const getPanelContent = (key: string) => {
    if (key === "dock-a") return <>This is the content of Dock A. <a href="#">Learn more</a></>;
    if (key === "dock-b") return <>This is the content of Dock B. <a href="#">Learn more</a></>;
    return randomContent();
};

const ViPanelsDemoPage = () => {
    const [dockPanels, setDockPanels] = useState(() => {
  
        return [{
            key: "dock-a",
            label: "Dock A",
            content: getPanelContent("dock-a"),
            style: { ...panelStyle, height: '300px' },
                closable: true
            },
            {
                key: "dock-b",
                label: "Dock B",
                content: getPanelContent("dock-b"),
                style: { ...panelStyle, height: '100%' },
                mode: "tab-before",
                refPanel: "dock-a"
            }
        ];
    });

    useEffect(() => {
        // Save all panel attributes except content
        // Note: content is not serializable, so we only save panel meta, not content
        localStorage.setItem(
            "dockPanels",
            JSON.stringify(
                dockPanels.map(
                    (panel: { content: unknown; [key: string]: unknown }) => {
                        const { content, ...rest } = panel;
                        return { ...rest };
                    }
                )
            )
        );
    }, [dockPanels]);

    // For navigation
    const scrollTo = (id: string) => {
        const el = document.getElementById(id);
        if (el) el.scrollIntoView({ behavior: "smooth", block: "start" });
    };

    const handleAddDockPanel = () => {
        const key = `dock-${Date.now()}`;
        setDockPanels(prev => [
            ...prev,
            {
                key,
                label: `Random ${key}`,
                content: randomContent(),
                style: { ...panelStyle, height: '200px' },
                closable: true
            }
        ]);
    };

    // Panel styles for mix demo
    const mixStyles = [
        { background: 'linear-gradient(135deg, #f8ffae 0%, #43c6ac 100%)', color: '#222', borderRadius: 4 },
        { background: 'linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 100%)', color: '#222', borderRadius: 4 },
        { background: 'linear-gradient(135deg,rgb(230, 241, 241) 0%, #a6c1ee 100%)', color: '#222', borderRadius: 4 },
        { background: 'linear-gradient(135deg,rgb(235, 242, 243) 0%, #f6d365 100%)', color: '#222', borderRadius: 4 }
    ];

    return (
        <div style={{ width: "100vw", height: "100%", padding: 16, boxSizing: "border-box", display: "flex", flexDirection: "column", gap: 8, overflow: "auto" }}>
            {/* Navigation Links */}
            <div style={{ flex: "0 0 auto", display: "flex", gap: 12, marginBottom: 8 }}>
                <Button variant="outlined" onClick={() => scrollTo("dock-section")}>Dock</Button>
                <Button variant="outlined" onClick={() => scrollTo("split-section")}>Split</Button>
                <Button variant="outlined" onClick={() => scrollTo("tab-section")}>Tab</Button>
                <Button variant="outlined" onClick={() => scrollTo("zoom-section")}>Zoom</Button>
                <Button variant="outlined" onClick={() => scrollTo("mix-section")}>Mix</Button>
                <Button variant="outlined" onClick={() => scrollTo("graph-map-section")}>Graph & Map</Button>
                <Button variant="contained" color="primary" startIcon={<AddIcon />} onClick={handleAddDockPanel} style={{ marginLeft: "auto" }}>
                    Add Panel
                </Button>
            </div>
            {/* Dockable Panels Demo */}
            <div id="dock-section">
                <h2>Dockable Panels</h2>
                <p>Click and drag panels to rearrange them. Close panels by clicking the 'x' button.</p>
                <ViDockPanel style={{ width: "100%" }} title="Hey Ramesh">
                    {dockPanels.map(panel => (
                        <ViPanel
                            key={panel.key}
                            id={panel.key}
                            label={panel.label}
                            style={panel.style}
                            closable={panel.closable}
                            mode={panel.mode}
                            refPanel={panel.refPanel}
                        >
                            {panel.content}
                        </ViPanel>
                    ))}
                </ViDockPanel>
            </div>

            {/* Split Panel Demo */}
            <div id="split-section">
                <h2>Split Panel</h2>
                <ViSplitPanel orientation="horizontal" spacing={4} panelPadding={10} borderWidth={60} style={{ width: "100%" }}>
                    <ViZoomPanel x={10} y={10} scale={0.63} style={{ width: "100%", height: "100%" }}>
                        <ViChartWidget label="Pie Chart" chartType="pie" style={{ width: '100%', height: '600px' }} />
                    </ViZoomPanel>
                    <ViPanel key="split-b" id="split-b" label="BBB" style={{ ...panelStyle, flex: 1 }}>
                        <h1>BBB Ipsum Presents</h1>
                        <p><strong>Pellentesque habitant morbi tristique</strong> senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. <em>Aenean ultricies mi vitae est.</em> Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, <code>commodo vitae</code>, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. <a href="#">Donec non enim</a> in turpis pulvinar facilisis. Ut felis.</p>
                    </ViPanel>
                </ViSplitPanel>
            </div>
            {/* Tab Panel Demo (scroll target) */}
            <div id="tab-section">
                <h2>Tab Panels</h2>
                <p>Try adding panels and see them appear as tabs!</p>
                {/* ViTabPanel sample */}
                {/*
                  To ensure charts render correctly when their tab becomes visible,
                  you can trigger a resize on tab change. Example below uses a key to force remount,
                  but for a robust solution, update ViTabPanel to call .resize() on the chart when activated.
                */}
                <ViTabPanel
                    style={{ width: "100%", height: '600px' }}
                    addButtonEnabled={true}
                    tab_placement="top"
                    tabsMovable={true}
                    label="Tab Panel Example"
                // onTabChange={(activeIndex) => {/* Optionally trigger chart resize here */}}
                >
                    <ViChartWidget
                        key="tab-chart-1"
                        id="tab-chart-1"
                        label="Radar Chart"
                        chartType="radar"
                        style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.radar.columns}
                        data={Array.isArray(defaultChartData.radar.data) && Array.isArray(defaultChartData.radar.data[0])
                            ? (defaultChartData.radar.data as unknown[][])
                            : undefined}
                    />
                    <ViChartWidget key="tab-chart-2" id="tab-chart-2" label="RadialBar Chart" chartType="radialbar" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.radialbar.columns} data={Array.isArray(defaultChartData.radialbar.data) && Array.isArray(defaultChartData.radialbar.data[0]) ? defaultChartData.radialbar.data as unknown[][] : undefined} />
                    <ViChartWidget key="tab-chart-3" id="tab-chart-3" label="Area Chart" chartType="area" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.area.columns} data={defaultChartData.area.data} />
                    <ViChartWidget key="tab-chart-4" id="tab-chart-4" label="Column Chart" chartType="column" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.column.columns} data={defaultChartData.column.data} />
                    <ViChartWidget key="tab-chart-5" id="tab-chart-5" label="Step Chart" chartType="step" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.step.columns} data={defaultChartData.step.data} />
                    <ViChartWidget key="tab-chart-6" id="tab-chart-6" label="Scatter Chart" chartType="scatter" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.scatter.columns} data={defaultChartData.scatter.data} />
                    <ViChartWidget key="tab-chart-7" id="tab-chart-8" label="Gantt Chart" chartType="gantt" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.gantt.columns}
                        data={[
                            ["Task 1", "2023-01-01", "2023-01-10"],
                            ["Task 2", "2023-01-11", "2023-01-20"],
                            ["Task 3", "2023-01-21", "2023-01-30"]
                        ]}
                    />
                    <ViChartWidget key="tab-chart-9" id="tab-chart-9" label="Contour Chart" chartType="contour" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.contour.columns}
                        data={Array.isArray(defaultChartData.contour.data) && Array.isArray(defaultChartData.contour.data[0]) ? defaultChartData.contour.data as unknown[][] : undefined}
                    />
                    <ViChartWidget key="tab-chart-10" id="tab-chart-10" label="Gauge Chart" chartType="gauge" style={{ width: '100%', height: '600px' }}
                        columns={defaultChartData.gauge.columns}
                        data={Array.isArray(defaultChartData.gauge.data) ? defaultChartData.gauge.data as number[] : [75]}
                    />


                    <div slot="tab-title">Tab One</div>
                    <ViPanel key="tab-one" id="tab-one" label="Tab One" style={panelStyle}>
                        <h3>Tab One Content</h3>
                        <p>This is the content of Tab One. <a href="#">Learn more</a></p>
                    </ViPanel>
                    <div slot="tab-title">Tab Two</div>
                    <ViPanel key="tab-two" id="tab-two" label="Tab Two" style={panelStyle}>
                        <h3>Tab Two Content</h3>
                        <p>This is the content of Tab Two. <a href="#">Learn more</a></p>
                    </ViPanel>
                    <div slot="tab-title">Tab Three</div>
                    <ViPanel key="tab-three" id="tab-three" label="Tab Three" style={panelStyle}>
                        <h3>Tab Three Content</h3>
                        <p>This is the content of Tab Three. <a href="#">Learn more</a></p>
                    </ViPanel>
                </ViTabPanel>
            </div>

            {/* Zoom Panel Demo */}
            <div id="zoom-section">
                <h2>Zoom Panel</h2>
                <ViZoomPanel x={10} y={10} scale={0.63} style={{ width: "100%", height: "300px" }}>
                    <ViPanel key="zoom-main" id="zoom-main" label="Zoom Content" style={panelStyle}>
                        <h1>HTML Ipsum Presents</h1>
                        <p><strong>Pellentesque habitant morbi tristique</strong> senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. <em>Aenean ultricies mi vitae est.</em> Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, <code>commodo vitae</code>, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. <a href="#">Donec non enim</a> in turpis pulvinar facilisis. Ut felis.</p>
                        <h2>Header Level 2</h2>
                        <ol>
                            <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li>
                            <li>Aliquam tincidunt mauris eu risus.</li>
                        </ol>
                        <blockquote><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.</p></blockquote>
                        <h3>Header Level 3</h3>
                        <ul>
                            <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li>
                            <li>Aliquam tincidunt mauris eu risus.</li>
                        </ul>
                    </ViPanel>
                </ViZoomPanel>
            </div>
            {/* Mix Demo Panel */}
            <div id="mix-section" style={{ backgroundColor: "yellow", borderRadius: 8, padding: 16 }}>
                <h2>Mix Demo</h2>
                <ViContainerPanel>
                    <ViSplitPanel spacing={10} style={{ width: "100%", height: "100%", backgroundColor: 'transparent' }}>
                        <ViPanel key="mix-dock" id="mix-dock" label="Docked" style={{ width: '100%', maxWidth: 400, height: '100%', backgroundColor: 'lightgrey' }}>
                            <p>This is a split panel in the mix demo.</p>

                            <ViSplitPanel orientation="vertical" spacing={10} style={{ height: 'calc(100% - 30px)', width: 'calc(100% - 10px)', margin: 0 }}>
                                <ViPanel key="mix-dock-2" id="mix-dock-2" label="Docked 2" style={{ ...mixStyles[0], height: '100%' }}>
                                    <p>This is another docked panel in the mix demo.</p>
                                </ViPanel>
                                <ViPanel key="mix-tab" id="mix-tab" label="Tab Panel" style={{ ...mixStyles[1], height: '100%' }}>
                                    <p>Tab Panel content in a ViPanel.</p>

                                </ViPanel>
                            </ViSplitPanel>
                        </ViPanel>

                        <ViDockPanel id="mix-dock-panel" style={{ flex: 1, width: '100%', height: '100%', backgroundColor: 'transparent' }}>
                            <ViPanel key="mix-tab" id="mix-tab" label="Tab Panel" style={{ width: '100%', height: '100%' }}>
                                <ViTabPanel tab_placement="top" tabsMovable={true} style={{ width: '100%', height: '100%' }} >
                                    <div slot="tab-title">Tab A</div>
                                    <ViPanel key="mix-tab-a" id="mix-tab-a" label="Tab A" style={{ ...mixStyles[2], width: '100%', height: '100%' }}>
                                        <p>Tab A content in a ViPanel.</p>
                                    </ViPanel>
                                    <div slot="tab-title">Tab B</div>
                                    <ViPanel key="mix-tab-b" id="mix-tab-b" label="Tab B" style={{ ...mixStyles[3], width: '100%', height: '100%' }}>
                                        <p>Tab B content in a ViPanel.</p>
                                    </ViPanel>
                                </ViTabPanel>
                            </ViPanel>

                            <ViPanel key="mix-zoom" id="mix-zoom" label="Zoom Panel" style={{ ...mixStyles[3], width: '100%', height: '100%' }}>
                                <ViZoomPanel x={20} y={20} scale={0.5} style={{ width: '100%', height: '100%' }}>
                                    <ViPanel key="mix-zoom-inner" id="mix-zoom-inner" label="Zoomed" style={{ ...mixStyles[2], width: '100%', height: '100%' }}>
                                        <h4>Zoomed Panel Content</h4>
                                        <p>This ViPanel is inside a ViZoomPanel in the mix demo.</p>
                                    </ViPanel>
                                </ViZoomPanel>
                            </ViPanel>
                        </ViDockPanel>
                    </ViSplitPanel>
                    <ViPanel key="mix-panel" id="mix-panel" label="Mix Panel" style={{ ...mixStyles[0], height: '100%', padding: 8 }}>
                        <h3>Mix Panel Content</h3>
                        <p>This is a mix panel that combines different ViPanel types.</p>
                    </ViPanel>
                </ViContainerPanel>
            </div>
        </div>
    );
};

export default ViPanelsDemoPage;
