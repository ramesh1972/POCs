<script>	
	import Demo from './Demo.svelte';
  
  import('sharedMFE/commonStyles').then((module) => {
    console.log('Loaded module:', module);
	}).catch((error) => {
    	console.error('Error loading module:', error);
	});

  console.log("url for me ", process.env.SHARED_MFE_URL);
  const baseURL = process.env.FOOTER_URL || 'http://localhost:8081';

</script>

<div class="common-container">
	<div class="common-style">Footer MFE App - Developed in Svelte&nbsp;<img src={`${baseURL}/assets/images/svelte.png`} alt="" class="svelte-logo"/></div>
	<div class="footer">visit my personal website @&nbsp;<a href="http://rameshv.me/ramesh">rameshv.me</a></div>
</div>
<style>
	.footer{
		background-color: white;
		font-size: 14px;
		font-weight: bold;
		text-align: right;
		height:100%;
		display: flex;
		padding:4px;
		justify-content: right;
		align-items: right;
		margin-top:20px;

	}
	.svelte-logo{
		width:13.5px;
		height: 13.5px;
	}

</style>
