/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useEffect, useRef, forwardRef } from "react";
import { Pie, Bar, Line, Area, Column, Step, Scatter, Bubble, Radar, RadialBar, Bullet, Contour, Gantt, Gauge, HalfPie, Heat, HexBin, QuarterPie, QuartileCandlestick, StatChart, Summary, WordCloud, XYAxis } from "@hpcc-js/chart";
import { ViWidget, type ViWidgetProps } from "./ViWidget";
import { defaultChartData } from "./ViChartDefaults";

export type ChartType =
  | "area"
  | "bar"
  | "bubble"
  | "bullet"
  | "column"
  | "contour"
  | "gantt"
  | "gauge"
  | "halfpie"
  | "heat"
  | "hexbin"
  | "line"
  | "pie"
  | "quarterpie"
  | "quartilecandlestick"
  | "radar"
  | "radialbar"
  | "scatter"
  | "statchart"
  | "step"
  | "summary"
  | "wordcloud"
  | "xyaxis";


export interface ViChartWidgetProps extends ViWidgetProps {
    chartType?: ChartType;
    columns?: string[];
    data?: unknown[][] | number[] | number;
    style?: React.CSSProperties;
    chartProps?: Record<string, unknown>;
}

export interface ViChartWidgetHandle {
    resize: () => void;
}

const chartMap = {
    area: Area,
    bar: Bar,
    bubble: Bubble,
    bullet: Bullet,
    column: Column,
    contour: Contour,
    gantt: Gantt,
    gauge: Gauge,
    halfpie: HalfPie,
    heat: Heat,
    hexbin: HexBin,
    line: Line,
    pie: Pie,
    quarterpie: QuarterPie,
    quartilecandlestick: QuartileCandlestick,
    radar: Radar,
    radialbar: RadialBar,
    scatter: Scatter,
    statchart: StatChart,
    step: Step,
    summary: Summary,
    wordcloud: WordCloud,
    xyaxis: XYAxis,
};


export const ViChartWidget = forwardRef<ViChartWidgetHandle, ViChartWidgetProps>(
    ({
        id,
        label,
        chartType = "pie",
        columns,
        data,
        style,
        className,
        chartProps = {},
        ...rest
    }, ref) => {
        const chartRef = useRef<HTMLDivElement>(null);
        const chartInstance = useRef<any>(null);
        const observerRef = useRef<IntersectionObserver | null>(null);

        useEffect(() => {
            const container = chartRef.current;
            if (!container) return;
            container.innerHTML = "";
            if (chartInstance.current && chartInstance.current.target) {
                chartInstance.current.target(null);
            }
            

            // Use chart-type-specific defaults if not provided
            const { columns: defaultCols, data: defaultData } = defaultChartData[chartType] || {};
            const usedColumns = columns ?? defaultCols;
            const usedData = data ?? defaultData;

            // Helper to create chart instance
            const createChart = (container: HTMLDivElement | null) => {
                if (!container) return null;
                const ChartCtor = chartMap[chartType] || Pie;
                const width = container.clientWidth;
                const height = container.clientHeight;
                const chart = new ChartCtor();
                if (usedColumns) chart.columns(usedColumns);
                if (usedData) chart.data(usedData);
                if (typeof chart.size === "function") {
                    chart.size([width, height]);
                }
                Object.entries(chartProps).forEach(([k, v]) => {
                    if (typeof (chart as any)[k] === "function") {
                        (chart as any)[k](v);
                    }
                });
                chart.target(container).render();
                if (typeof chart.render === "function") {
                    chart.render();
                }
                return chart;
            };

            chartInstance.current = createChart(container);

            // Observe visibility changes
            if (observerRef.current) observerRef.current.disconnect();
            observerRef.current = new window.IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        // Destroy and recreate chart instance on visibility
                        if (chartInstance.current && chartInstance.current.target) {
                            chartInstance.current.target(null);
                        }
                        container.innerHTML = "";
                        chartInstance.current = createChart(container);
                    }
                });
            }, { threshold: 0.01 });

            observerRef.current.observe(container);

            return () => {
                if (chartInstance.current && chartInstance.current.target) chartInstance.current.target(null);
                if (container) container.innerHTML = "";
                chartInstance.current = null;
                if (observerRef.current) observerRef.current.disconnect();
            };
        }, [chartType, columns, data, chartProps]);

        return (
            <ViWidget id={id} label={label} style={style} className={className} {...rest}>
                <div ref={chartRef} style={style} />
            </ViWidget>
        );
    }
);

export default ViChartWidget;
