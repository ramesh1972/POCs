import GridLayout from "react-grid-layout";
import React from "react";

import { Responsive, WidthProvider } from "react-grid-layout";

const ResponsiveGridLayout = WidthProvider(Responsive);
import "react-grid-layout/css/styles.css";
import "react-resizable/css/styles.css";

class Layout extends React.Component<any> {
    state: { layout: any[] };

    constructor(props: any) {
        super(props);
        this.state = {
            layout: this.props.layout || [
                { i: "a", x: 0, y: 0, w: 1, h: 2, static: true },
                { i: "b", x: 1, y: 2, w: 3, h: 2, minW: 2, maxW: 4 },
                { i: "c", x: 4, y: 1, w: 4, h: 2 }
            ]
        };
    }
    // Removed invalid useMemo hook. If you need to generate children dynamically, use a method or do it in render.
    getChildren() {
        const count = this.state.layout.length;
        // Generate children based on the layout count
        return this.state.layout.map((item: any) => (
            <div key={item.i} style={{ backgroundColor: "lightgray", padding: "10px", border: "1px solid black" }}>
                {item.i}
            </div>
        ));
    }

    onLayoutChange = (layout: any[]) => {
        this.setState({ layout });
               // Optionally save the layout to localStorage or a server
        //localStorage.setItem("layout", JSON.stringify(layout));
    };
    render() {
        // Responsive layouts object for different breakpoints
        const layouts = {
            lg: this.state.layout,
            md: this.state.layout,
            sm: this.state.layout,
            xs: this.state.layout,
        };
        return (
            <>
                <GridLayout
                    className="layout"
                    layout={layouts.lg}
                    cols={12}
                    rowHeight={20}
                    width={1200}
                    isResizable={true}
                    margin={[2, 30]}
                >
                    <div key="a" style={{ backgroundColor: "yellow" }}>1</div>
                    <div key="b" style={{ backgroundColor: "lightgreen" }}>2</div>
                    <div key="c" style={{ backgroundColor: "lightblue" }}>3</div>
                    
                </GridLayout>
                <ResponsiveGridLayout
                    className="layout"
                    layouts={layouts}
                    breakpoints={{ lg: 1200, md: 996, sm: 768, xs: 480, xxs: 0 }}
                    cols={{ lg: 12, md: 10, sm: 6, xs: 4, xxs: 2 }}
                    rowHeight={30}
                >
                    <div key="a" style={{ backgroundColor: "yellow" }}>1</div>
                    <div key="b" style={{ backgroundColor: "lightgreen" }}>2</div>
                    <div key="c" style={{ backgroundColor: "lightblue" }}>3</div>

                </ResponsiveGridLayout>
                <h1>save/load</h1>
                <button onClick={() => {
                    const layout = this.state.layout;
                    localStorage.setItem("layout", JSON.stringify(layout));
                }}>Save Layout</button>
                <button onClick={() => {
                    const savedLayout = localStorage.getItem("layout");
                    if (savedLayout) {
                        this.setState({ layout: JSON.parse(savedLayout) });
                    }
                }}>Load Layout</button>
                <GridLayout className="layout" cols={12} rowHeight={70} width={1200} layout={this.state.layout} onLayoutChange={this.onLayoutChange}>{this.getChildren()}</GridLayout>;
            </>
        );

    }
}

export default Layout;