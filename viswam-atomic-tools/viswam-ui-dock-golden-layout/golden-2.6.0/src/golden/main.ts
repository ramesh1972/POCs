import { App } from './app';

// Run with URL: http://localhost:3000/api-test/dist/

declare global {
    interface Window {
        goldenLayoutApiTestApp: App;
    }
}

if (document.readyState !== "loading") run();
// in case the document is already rendered
else document.addEventListener("DOMContentLoaded", () => run()); // Wrap run in an arrow function to ignore event argument

export default function run(controlsElement?: HTMLElement, layoutElement?: HTMLElement) {
    const app = new App(controlsElement, layoutElement);
    window.goldenLayoutApiTestApp = app;
    app.start();
    return app; // Return the app instance for use in React
}
