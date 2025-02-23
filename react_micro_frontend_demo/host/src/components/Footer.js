import React, { useEffect, useRef } from "react";
import "./Footer.css";

const FooterModule = () => {
  const ref = useRef(null);

  useEffect(() => {
    console.log('Loading module in FooterModule...');
    import('footer/footerModule').then((module) => {
      console.log('Loaded module:', module);
      module.mount(ref.current);
    }).catch((error) => {
      console.error('Error loading module:', error);
    });

    //mount(ref.current);
  }, []);

  return <div className="footer-module" ref={ref} />;
};

export default FooterModule;