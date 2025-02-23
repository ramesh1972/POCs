import App from './App.svelte';

const FooterApp = new App({
	target: document.getElementById('root'),
	props: {
		name: 'world'
	}
});

export default FooterApp;
