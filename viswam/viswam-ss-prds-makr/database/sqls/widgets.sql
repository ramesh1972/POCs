-- create table for widget_effects in mysql
CREATE TABLE widget_effects_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert the following widget effects
INSERT INTO widget_effects_master (name, description) VALUES ('Grow Effect', 'Grow in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Shrink Effect', 'Shrink in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Move Effect', 'Move in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Swing Effect', 'Swing in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Highlight Effect', 'Highlight in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Explode Effect', 'Explode in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Implode Effect', 'Implode in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Fold Effect', 'Fold in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Unfold Effect', 'Unfold in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Drop Effect', 'Drop in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Puff Effect', 'Puff in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Squish Effect', 'Squish in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Wobble Effect', 'Wobble in and out');
INSERT INTO widget_effects_master (name, description) VALUES ('Jiggle Effect', 'Jiggle in and out');


INSERT INTO widget_effects_master (name, description) VALUES
    ('Hover Effect', 'Changes in appearance when the cursor hovers over a widget, such as color change, underline, or tooltip display.'),
    ('Click Effect', 'Visual feedback when a widget is clicked, such as a change in color, size, or shape to indicate the click action.'),
    ('Focus Effect', 'Visual indication that a widget has received keyboard focus, typically shown by a border or outline around the widget.'),
    ('Transition Effect', 'Smooth animation applied to widget state changes, such as fading, sliding, or scaling, to provide a more polished user experience.'),
    ('Drag and Drop Effect', 'Visual feedback during drag-and-drop interactions, such as a shadow or outline of the dragged widget, to indicate its position.'),
    ('Error Effect', 'Visual indication of errors or validation messages associated with widgets, such as highlighting the widget in red or displaying an error icon.'),
    ('Loading Effect', 'Visual feedback to indicate that content is being loaded or processed, such as a spinner, progress bar, or shimmering effect.'),
    ('Scrolling Effect', 'Visual changes in response to scrolling actions, such as parallax effects, lazy loading of content, or sticky headers.'),
    ('Modal Effect', 'Overlay or transition effect used to display modal dialogs or pop-up windows, such as fading in/out or sliding from the side.'),
    ('Blur Effect', 'Applied to background content when displaying a modal or overlay to bring focus to the foreground content.'),
    ('Drop-Down Effect', 'Animation or transition applied to show or hide drop-down menus or lists, such as sliding, fading, or expanding/collapsing.'),
    ('Accordion Effect', 'Animation applied to expand or collapse accordion-style widgets, typically using sliding or fading transitions.'),
    ('Carousel Effect', 'Animation applied to carousel or slider widgets to transition between slides, such as sliding, fading, or zooming.'),
    ('Ripple Effect', 'Circular animation emanating from the point of interaction (e.g., touch or click) to provide tactile feedback, commonly used in material design interfaces.'),
    ('Glow Effect', 'Soft glowing effect applied to widgets to highlight them or create an illusion of depth and interactivity.'),
    ('Shadow Effect', 'Adds a shadow to the widget, creating a sense of depth and elevation.'),
    ('Reflection Effect', 'Creates a reflection of the widget below it, simulating a reflective surface.'),
    ('Pulse Effect', 'Causes the widget to pulsate or throb in size, drawing attention to it.'),
    ('Rotate Effect', 'Rotates the widget around its center or axis, providing a dynamic appearance.'),
    ('Scale Effect', 'Scales the widget up or down in size, giving an impression of zooming.'),
    ('Flip Effect', 'Flips the widget horizontally or vertically, providing a flipping animation.'),
    ('Slide Effect', 'Slides the widget in or out of view, typically used for reveal or hide animations.'),
    ('Fade Effect', 'Gradually fades the widget in or out of view, creating a smooth transition.'),
    ('Shake Effect', 'Causes the widget to shake or jitter briefly, indicating an error or alert.'),
    ('Bounce Effect', 'Bounces the widget up and down or side to side, creating a bouncing animation.'),
    ('Spin Effect', 'Spins the widget around its center or axis, providing a spinning animation.'),
    ('Glowing Border Effect', 'Adds a glowing border around the widget, drawing attention to it.'),
    ('Water Ripple Effect', 'Creates a ripple effect on the widget, simulating water ripples.'),
    ('Fire Effect', 'Applies a fiery animation to the widget, simulating flames or fire.'),
    ('Morph Effect', 'Gradually transforms the shape or appearance of the widget into another shape.'),
    ('Tilt Effect', 'Tilts the widget slightly in a particular direction, adding a sense of dynamism.'),
    ('Explosion Effect', 'Simulates an explosion animation around the widget, dispersing fragments.'),
    ('Panning Effect', 'Moves the widget smoothly in a particular direction, simulating panning.'),
    ('Neon Glow Effect', 'Adds a neon glow effect to the widget, creating a futuristic appearance.'),
    ('Puzzle Effect', 'Breaks the widget into puzzle-like pieces and reassembles them.'),
    ('Magnet Effect', 'Attracts or repels nearby widgets, simulating magnetic forces.'),
    ('Elastic Effect', 'Stretches or squashes the widget like elastic material.'),
    ('Pixelate Effect', 'Pixelates the widget, making it appear as if composed of pixels.'),
    ('Ghosting Effect', 'Creates a translucent copy of the widget that follows the cursor.'),
    ('Ink Effect', 'Simulates ink spreading across the widget surface.'),
    ('Mosaic Effect', 'Turns the widget into a mosaic of small tiles or fragments.'),
    ('Spiral Effect', 'Transforms the widget into a spiral shape, expanding or contracting.'),
    ('Galaxy Effect', 'Creates a swirling pattern around the widget, like a galaxy.'),
    ('Flare Effect', 'Adds a lens flare effect to the widget, creating a bright highlight.'),
    ('Weather Effect', 'Simulates weather phenomena around the widget, such as rain or snow.'),
    ('Throbber Effect', 'Displays a throbber animation to indicate ongoing activity.'),
    ('Clock Effect', 'Rotates the widget like the hands of a clock, indicating passage of time.'),
    ('Barcode Effect', 'Transforms the widget into a barcode pattern.'),
    ('Glitch Effect', 'Simulates a glitch or distortion effect on the widget.'),
    ('Warp Effect', 'Warps the widget shape or appearance, creating a surreal effect.'),
    ('Dissolve Effect', 'Gradually dissolves the widget into particles, disappearing.'),
    ('Magnifying Glass Effect', 'Enlarges a portion of the widget under a magnifying glass.'),
    ('Chroma Key Effect', 'Replaces a specific color in the widget with transparency.'),
    ('Fog Effect', 'Surrounds the widget with a fog or mist, obscuring visibility.'),
    ('Tornado Effect', 'Creates a swirling tornado-like animation around the widget.'),
    ('Retro Effect', 'Applies a retro-style filter or effect to the widget.'),
    ('Vortex Effect', 'Generates a vortex or whirlpool animation around the widget.'),
    ('Crack Effect', 'Simulates cracks forming on the surface of the widget.'),
    ('Blink Effect', 'Causes the widget to blink or flash intermittently.'),
    ('Snowflake Effect', 'Adds falling snowflakes or snow particles around the widget.'),
    ('Fireworks Effect', 'Simulates a fireworks display around the widget.'),
    ('Bullet Effect', 'Moves the widget rapidly in a straight line, like a bullet.'),
    ('Psychedelic Effect', 'Creates a psychedelic or trippy visual effect on the widget.'),
    ('Gravity Effect', 'Simulates gravitational forces acting on the widget.'),
    ('Underwater Effect', 'Gives the widget an underwater appearance, with ripples and distortion.'),
    ('Heartbeat Effect', 'Causes the widget to pulse or throb rhythmically, like a heartbeat.'),
    ('Magic Wand Effect', 'Simulates the effect of a magic wand casting a spell on the widget.'),
    ('Metamorphosis Effect', 'Gradually transforms the widget into a different object or shape.'),
    ('Siren Effect', 'Simulates a flashing siren or emergency light around the widget.'),
    ('Galactic Warp Effect', 'Distorts the widget as if its being sucked into a black hole.'),
    ('Steam Effect', 'Generates steam or vapor rising from the surface of the widget.'),
    ('Liquid Effect', 'Simulates the widget transforming into a liquid and flowing.'),
    ('Crumble Effect', 'Causes the widget to crumble or disintegrate into pieces.'),
    ('Electric Spark Effect', 'Generates electric sparks or arcs around the widget.'),
    ('Dimensional Warp Effect', 'Distorts the widget as if its traveling through a dimensional warp.'),
    ('Alien Abduction Effect', 'Simulates an alien abduction beam shining on the widget.'),
    ('Invisibility Effect', 'Makes the widget temporarily invisible, gradually fading in and out.'),
    ('Dust Storm Effect', 'Creates a swirling dust storm animation around the widget.'),
    ('Mind Control Effect', 'Simulates mind control waves emanating from the widget.'),
    ('Time Warp Effect', 'Distorts the widget as if its experiencing a time warp or time dilation.'),
    ('Teleportation Effect', 'Simulates the widget disappearing and reappearing in a different location.'),
    ('Matrix Effect', 'Creates a scrolling matrix of characters or symbols on the widget.'),
    ('Plasma Effect', 'Generates swirling plasma or energy patterns around the widget.'),
    ('Levitation Effect', 'Causes the widget to hover or levitate above the surface.'),
    ('Aurora Effect', 'Simulates the northern lights (aurora borealis) dancing around the widget.'),
    ('Infrared Effect', 'Gives the widget an infrared or thermal imaging appearance.'),
    ('Gravitational Lensing Effect', 'Distorts the widget as if its being affected by gravitational lensing.'),
    ('Photon Beam Effect', 'Simulates a photon beam shining on the widget.'),
    ('Quantum Tunneling Effect', 'Simulates the widget tunneling through quantum dimensions.'),
    ('Holographic Projection Effect', 'Projects a holographic image or message from the widget.'),
    ('Nuclear Explosion Effect', 'Simulates a nuclear explosion shockwave around the widget.'),
    ('Time Travel Effect', 'Distorts the widget as if its traveling through time.'),
    ('Techno-Organic Effect', 'Simulates a techno-organic transformation of the widget.');

-- create table for widget_themes_master
CREATE TABLE widget_themes_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert the following widget designs
INSERT INTO widget_themes_master (name, description) VALUES ('Flat Design', 'Simple, minimalistic design with clean lines and solid colors, often used in modern web and mobile interfaces.');
INSERT into widget_themes_master (name, description) values ('Material Design','A design system by Google that uses depth, surfaces, and ink-like colors.');
INSERT into widget_themes_master (name, description) values ('Skeuomorphic Design','Design mimics real-world objects and materials.');
INSERT into widget_themes_master (name, description) values ('Neumorphism','A modern take on Skeuomorphism, featuring soft shadows and highlights.');
INSERT into widget_themes_master (name, description) values ('Brutalist Design','A raw, unpolished design often characterized by bold colors and large typography.');
INSERT into widget_themes_master (name, description) values ('Glassmorphism','UI featuring frosted-glass elements with multi-layered UI, light, and transparency.');
INSERT into widget_themes_master (name, description) values ('Swiss Design','Focus on typography and layout, originated in Switzerland.');
INSERT into widget_themes_master (name, description) values ('Metro UI','Microsofts tile-based interface, emphasizing content and typography.');
INSERT into widget_themes_master (name, description) values ('Minimalist','A bare-bones design focusing only on essential elements.');
INSERT into widget_themes_master (name, description) values ('Retro','Vintage-inspired design featuring old-school graphics and typography.');
INSERT into widget_themes_master (name, description) values ('Dark Mode','A UI with a dark background color scheme.');
INSERT into widget_themes_master (name, description) values ('Parallax Scrolling','Background images move slower than the foreground for a 3D effect.');
INSERT into widget_themes_master (name, description) values ('Zine Culture','Reflects the raw, hand-made aesthetic of fanzines.');
INSERT into widget_themes_master (name, description) values ('Monochromatic','Uses variations of a single color to create the design.');
INSERT into widget_themes_master (name, description) values ('Duotone','Uses two colors throughout the design.');
INSERT into widget_themes_master (name, description) values ('Isometric Design','3D-like design without the need for 3D software.');
INSERT into widget_themes_master (name, description) values ('Geometric Design','Use of geometric shapes like squares, circles, and triangles.');
INSERT into widget_themes_master (name, description) values ('Liquid Design','Fluid layouts that adapt to the screen size.');
INSERT into widget_themes_master (name, description) values ('Cards UI','Information presented in rectangular or square containers.');
INSERT into widget_themes_master (name, description) values ('Hero Images','Large, compelling visuals placed prominently.');
INSERT into widget_themes_master (name, description) values ('Big Typography','Use of oversized letters for dramatic impact.');
INSERT into widget_themes_master (name, description) values ('Modular Design','Block grid-based layout for better scalability and readability.');
INSERT into widget_themes_master (name, description) values ('Split Screen','Screen divided into two or more parts to show different content.');
INSERT into widget_themes_master (name, description) values ('Fixed Navigation','Navigation stays in the same spot as users scroll.');
INSERT into widget_themes_master (name, description) values ('Infinite Scrolling','Content loads continuously as the user scrolls down.');
INSERT into widget_themes_master (name, description) values ('Carousel','Rotating set of images or content.');
INSERT into widget_themes_master (name, description) values ('Hamburger Menu','A navigation option that opens into a menu when clicked.');
INSERT into widget_themes_master (name, description) values ('Mega Menu','A large drop-down menu showing all options in one main, mega-panel.');
INSERT into widget_themes_master (name, description) values ('Collapsible Menu','A menu that expands and collapses upon interaction.');
INSERT into widget_themes_master (name, description) values ('Fitt’s Law','Design focusing on the size and distance of interactive elements.');
INSERT into widget_themes_master (name, description) values ('Single Page Application','A web app or website that interacts dynamically with the user.');
INSERT into widget_themes_master (name, description) values ('Lazy Loading','Content loads as its needed rather than all at once.');
INSERT into widget_themes_master (name, description) values ('Ghost Buttons','Transparent and flat buttons that blend into the background.');
INSERT into widget_themes_master (name, description) values ('Grid Layout','Content arranged into rows and columns.');
INSERT into widget_themes_master (name, description) values ('Full-Screen Pop-Up','A pop-up that covers the entire screen, often used for notifications or prompts.');
INSERT into widget_themes_master (name, description) values ('Contextual Action','Actions related directly to selected text or elements.');
INSERT into widget_themes_master (name, description) values ('FAB (Floating Action Button)','A circular button that performs the apps primary action.');
INSERT into widget_themes_master (name, description) values ('Video Backgrounds','Full-screen video content behind website UI.');
INSERT into widget_themes_master (name, description) values ('Microinteractions','Small animations or design elements that guide or inform the user.');
INSERT into widget_themes_master (name, description) values ('Thumb-Friendly Design','Design tailored for ease of thumb navigation on mobile devices.');
INSERT into widget_themes_master (name, description) values ('Tabbed Navigation','Horizontal menu that allows switching between views or sub-pages.');
INSERT into widget_themes_master (name, description) values ('Animated Icons','Icons with subtle animations to indicate action or state.');
INSERT into widget_themes_master (name, description) values ('Stacked Navigation','Multi-level drill-down navigation usually for mobile devices.');
INSERT into widget_themes_master (name, description) values ('Drawer Navigation','Off-screen navigation elements that slide in from the side.');
INSERT into widget_themes_master (name, description) values ('Bottom Sheet','A sheet that slides up from the bottom of the mobile screen for extra options.');
INSERT into widget_themes_master (name, description) values ('Augmented Reality Interface','UI elements overlaid on real-world imagery.');
INSERT into widget_themes_master (name, description) values ('Virtual Reality Interface','UI tailored for immersive, 3D virtual environments.');
INSERT into widget_themes_master (name, description) values ('Voice-Activated UI','Interface controlled by voice commands.');
INSERT into widget_themes_master (name, description) values ('Tactile Feedback','Haptic feedback like vibration in response to interactions.');
INSERT into widget_themes_master (name, description) values ('Biometric Authentication','Using fingerprint or face recognition as an interface component.');
INSERT into widget_themes_master (name, description) values ('Dashboard UI','Interface resembling a car or airplane dashboard, often for data visualization.');
INSERT into widget_themes_master (name, description) values ('Widget-Based','Interface comprising movable and customizable widgets.');
INSERT into widget_themes_master (name, description) values ('Responsive Design','Design that adapts to different screen sizes.');
INSERT into widget_themes_master (name, description) values ('Adaptive Design','Design that serves different features based on device capabilities.');
INSERT into widget_themes_master (name, description) values ('Progressive Disclosure','Revealing information progressively to avoid overwhelming the user.');
INSERT into widget_themes_master (name, description) values ('Kinetic Typography','Animated, moving text.');
INSERT into widget_themes_master (name, description) values ('Mood-Based UI','UI changes based on detected or selected mood.');
INSERT into widget_themes_master (name, description) values ('Data-Driven UI','UI changes dynamically based on data analytics or user behavior.');
INSERT into widget_themes_master (name, description) values ('Avatar UI','Interface where users interact through a digital avatar.');
INSERT into widget_themes_master (name, description) values ('Walkthroughs','Guided tours to introduce features or steps.');
INSERT into widget_themes_master (name, description) values ('Gooey Effect','Liquid-like movement and transitions.');
INSERT into widget_themes_master (name, description) values ('Cookie Cutter','A standard, non-customizable UI design.');
INSERT into widget_themes_master (name, description) values ('Conversational UI','Interface designed for chat or voice-based interaction.');
INSERT into widget_themes_master (name, description) values ('Cinemagraphs','Static images with isolated, looping animations.');
INSERT into widget_themes_master (name, description) values ('Blurred Background','Background images that are intentionally out of focus.');
INSERT into widget_themes_master (name, description) values ('Vignette','Soft shading at the edges of images or layouts.');
INSERT into widget_themes_master (name, description) values ('Tiled Backgrounds','Repeating background images forming a pattern or texture.');
INSERT into widget_themes_master (name, description) values ('Watercolor','Design mimicking watercolor paint effects.');
INSERT into widget_themes_master (name, description) values ('Gradients','Smooth color transitions used in backgrounds or elements.');
INSERT into widget_themes_master (name, description) values ('Hand-Drawn Elements','Graphics that look hand-drawn or sketched.');
INSERT into widget_themes_master (name, description) values ('Origami/Folded Design','Design mimics folded or layered paper.');
INSERT into widget_themes_master (name, description) values ('Outline Icons','Icons represented with just their outlines.');
INSERT into widget_themes_master (name, description) values ('Rich Illustrations','Detailed, often playful illustrations.');
INSERT into widget_themes_master (name, description) values ('Frosted Glass Effect','UI elements with a blurred, translucent background similar to frosted glass.');
INSERT into widget_themes_master (name, description) values ('Glitch Effect','Intentionally distorted or disrupted elements for a "glitchy" feel.');
INSERT into widget_themes_master (name, description) values ('Depth & Shadows','Use of shadows to create a sense of depth.');
INSERT into widget_themes_master (name, description) values ('Analogous Colors','Color scheme based on adjacent colors on the color wheel.');
INSERT into widget_themes_master (name, description) values ('Complementary Colors','Color scheme based on opposite colors on the color wheel.');
INSERT into widget_themes_master (name, description) values ('Triadic Colors','Color scheme based on three evenly spaced colors on the color wheel.');
INSERT into widget_themes_master (name, description) values ('Textured UI','Interface incorporates textures like wood, metal, or fabric.');
INSERT into widget_themes_master (name, description) values ('Bokeh Effects','Use of blurred, out-of-focus light points.');
INSERT into widget_themes_master (name, description) values ('Chromatic Aberration','Intentional color fringing for a retro, distorted look.');
INSERT into widget_themes_master (name, description) values ('Particle Effects','Dynamic, animated particles for visual interest.');
INSERT into widget_themes_master (name, description) values ('Ink Bleed','Simulates ink spreading or bleeding on paper.');
INSERT into widget_themes_master (name, description) values ('Noise Texture','Subtle grainy texture for a vintage or tactile feel.');
INSERT into widget_themes_master (name, description) values ('Pixel Art','Graphics created with pixel-level detail.');
INSERT into widget_themes_master (name, description) values ('Scribbles & Doodles','Hand-drawn elements like scribbles or doodles.');
INSERT into widget_themes_master (name, description) values ('Stitching','Design elements that look like stitched fabric or leather.');
INSERT into widget_themes_master (name, description) values ('Stained Glass','Design elements that mimic the look of stained glass windows.');
INSERT into widget_themes_master (name, description) values ('Metallics','Design elements that look like metal surfaces.');
INSERT into widget_themes_master (name, description) values ('Wood Grain','Design elements that mimic the look of wood grain.');
INSERT into widget_themes_master (name, description) values ('Marble','Design elements that mimic the look of marble.');
INSERT into widget_themes_master (name, description) values ('Leather','Design elements that mimic the look of leather.');
INSERT into widget_themes_master (name, description) values ('Fabric','Design elements that mimic the look of fabric.');
INSERT into widget_themes_master (name, description) values ('Paper','Design elements that mimic the look of paper.');
INSERT into widget_themes_master (name, description) values ('Glass','Design elements that mimic the look of glass.');
INSERT into widget_themes_master (name, description) values ('Plastic','Design elements that mimic the look of plastic.');
INSERT into widget_themes_master (name, description) values ('Ceramic','Design elements that mimic the look of ceramic.');
INSERT into widget_themes_master (name, description) values ('Concrete','Design elements that mimic the look of concrete.');
INSERT into widget_themes_master (name, description) values ('Brick','Design elements that mimic the look of brick.');
INSERT into widget_themes_master (name, description) values ('Stone','Design elements that mimic the look of stone.');
INSERT into widget_themes_master (name, description) values ('Metal','Design elements that mimic the look of metal.');
INSERT into widget_themes_master (name, description) values ('Rust','Design elements that mimic the look of rust.');
INSERT into widget_themes_master (name, description) values ('Grunge','Design elements that mimic the look of grunge textures.');
INSERT into widget_themes_master (name, description) values ('Glossy','Design elements that mimic the look of glossy surfaces.');
INSERT into widget_themes_master (name, description) values ('Matte','Design elements that mimic the look of matte surfaces.');
INSERT into widget_themes_master (name, description) values ('Satin','Design elements that mimic the look of satin textures.');
INSERT into widget_themes_master (name, description) values ('Velvet','Design elements that mimic the look of velvet textures.');
INSERT into widget_themes_master (name, description) values ('Silk','Design elements that mimic the look of silk textures.');
INSERT into widget_themes_master (name, description) values ('Linen','Design elements that mimic the look of linen textures.');
INSERT into widget_themes_master (name, description) values ('Cotton','Design elements that mimic the look of cotton textures.');
INSERT into widget_themes_master (name, description) values ('Wool','Design elements that mimic the look of wool textures.');
INSERT into widget_themes_master (name, description) values ('Fur','Design elements that mimic the look of fur textures.');
INSERT into widget_themes_master (name, description) values ('Feathers','Design elements that mimic the look of feather textures.');
INSERT into widget_themes_master (name, description) values ('Scale','Design elements that mimic the look of scale textures.');

-- create table widget_styles_master for mysql with columns
-- Style Name
-- Description
-- System Style Name
-- Class
-- Class Group
-- Style Value Data Type
-- Style Min Value
-- Style Max Value
-- Style Values List
-- Primary UI Type

CREATE TABLE widget_styles_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    system_style_name VARCHAR(255),
    class VARCHAR(255),
    class_group VARCHAR(255),
    style_value_data_type VARCHAR(255),
    style_min_value CHAR(16) DEFAULT 'NA',
    style_max_value CHAR(16) DEFAULT 'NA',
    style_values_list TEXT,
    primary_ui_type VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert the following widget styles
INSERT INTO widget_styles_master (name, description, system_style_name, class, class_group, style_value_data_type, style_min_value, style_max_value, style_values_list, primary_ui_type) VALUES 
('color','Text color','Color','Text','Text Styling','String','N/A','N/A','Hex, RGBA, Color Name',''),
('background-color','Background color','Background','Background','Background Styling','String','N/A','N/A','Hex, RGBA, Color Name',''),
('width','Element width','Dimension','Dimension','Layout','Number','0','∞','px, em, %, vw, etc.',''),
('height','Element height','Dimension','Dimension','Layout','Number','0','∞','px, em, %, vh, etc.',''),
('font-size','Text font size','Font','Text','Text Styling','Number','0','∞','px, em, rem, %, etc.',''),
('margin','Outer spacing','Spacing','Spacing','Layout','Number','-∞','∞','px, em, %, etc.',''),
('padding','Inner spacing','Spacing','Spacing','Layout','Number','0','∞','px, em, %, etc.',''),
('border','Border style and color','Border','Border','Layout','String','N/A','N/A','solid, dashed, dotted, etc.',''),
('position','Element position','Positioning','Position','Layout','String','N/A','N/A','static, relative, absolute, fixed, sticky',''),
('display','Display type','Box Model','Display','Layout','String','N/A','N/A','block, inline, inline-block, flex, grid, etc.',''),
('z-index','Stack order','Layer','Z-index','Layout','Number','-∞','∞','Integer values',''),
('opacity','Transparency','Color','Transparency','Visual Effects','Number','0','1','0 to 1',''),
('text-align','Text alignment','Text','Text','Text Styling','String','N/A','N/A','left, right, center, justify',''),
('line-height','Line spacing','Spacing','Text','Text Styling','Number/String','0','∞','px, em, %, etc.',''),
('font-weight','Text thickness','Font','Text','Text Styling','Number/String','100','900','100, 200, ... 900, bold, normal',''),
('border-radius','Corner rounding','Border','Border','Layout','Number','0','∞','px, em, %, etc.',''),
('overflow','Content overflow','Box Model','Overflow','Layout','String','N/A','N/A','visible, hidden, scroll, auto',''),
('background-image','Background image','Background','Background','Background Styling','String','N/A','N/A','URL, base64, etc.',''),
('cursor','Cursor style','User Interaction','Cursor','Interaction','String','N/A','N/A','pointer, default, text, etc.',''),
('float','Element float','Positioning','Float','Layout','String','N/A','N/A','left, right, none',''),
('clear','Clear float','Positioning','Clear','Layout','String','N/A','N/A','left, right, both, none',''),
('text-decoration','Text underline, overline, etc.','Text','Text','Text Styling','String','N/A','N/A','none, underline, overline, line-through',''),
('list-style-type','List item marker style','List','List','List Styling','String','N/A','N/A','disc, circle, square, none',''),
('vertical-align','Vertical alignment','Alignment','Vertical','Layout','String','N/A','N/A','baseline, top, middle, bottom, etc.',''),
('box-shadow','Box shadow','Shadow','Box Shadow','Visual Effects','String','N/A','N/A','none, color, x, y, blur, spread',''),
('flex-direction','Flexbox direction','Flexbox','Flexbox','Layout','String','N/A','N/A','row, column, row-reverse, column-reverse',''),
('transition','Transition effects','Animation','Transition','Visual Effects','String','N/A','N/A','property, duration, timing, delay',''),
('animation','Keyframe animations','Animation','Animation','Visual Effects','String','N/A','N/A','name, duration, timing, delay, iteration',''),
('clip-path','Clipping path','Mask','Clipping','Visual Effects','String','N/A','N/A','none, url, polygon, circle, etc.',''),
('object-fit','Replacing content fit','Sizing','Object Fit','Visual Effects','String','N/A','N/A','fill, contain, cover, none, scale-down',''),
('transform','2D/3D transformations','Transformation','Transform','Visual Effects','String','','','',''),
('grid-template-rows','Define grid rows','Grid','Grid','Layout','String','N/A','N/A','fr, px, %, auto',''),
('grid-template-columns','Define grid columns','Grid','Grid','Layout','String','N/A','N/A','fr, px, %, auto',''),
('grid-row-start','Grid row start position','Grid','Grid','Layout','Number/String','N/A','N/A','auto, 1, 2, 3, ...',''),
('grid-row-end','Grid row end position','Grid','Grid','Layout','Number/String','N/A','N/A','auto, 1, 2, 3, ...',''),
('grid-column-start','Grid column start position','Grid','Grid','Layout','Number/String','N/A','N/A','auto, 1, 2, 3, ...',''),
('grid-column-end','Grid column end position','Grid','Grid','Layout','Number/String','N/A','N/A','auto, 1, 2, 3, ...',''),
('outline','Element outline','Outline','Outline','Visual Effects','String','N/A','N/A','none, px solid color',''),
('visibility','Element visibility','Display','Visibility','Layout','String','N/A','N/A','visible, hidden, collapse',''),
('justify-content','Horizontal alignment in Flexbox/Grid','Alignment','Flexbox','Layout','String','N/A','N/A','flex-start, flex-end, center, space-between, ...',''),
('align-items','Vertical alignment in Flexbox/Grid','Alignment','Flexbox','Layout','String','N/A','N/A','flex-start, flex-end, center, baseline, ...',''),
('text-transform','Text capitalization','Text','Text','Text Styling','String','N/A','N/A','none, uppercase, lowercase, capitalize',''),
('letter-spacing','Spacing between characters','Text','Text','Text Styling','Number','-∞','∞','px, em, rem',''),
('white-space','Whitespace handling','Text','Text','Text Styling','String','N/A','N/A','normal, nowrap, pre, pre-wrap, pre-line',''),
('min-width','Minimum element width','Dimension','Min Width','Layout','Number/String','0','∞','px, em, %, auto',''),
('min-height','Minimum element height','Dimension','Min Height','Layout','Number/String','0','∞','px, em, %, auto',''),
('max-width','Maximum element width','Dimension','Max Width','Layout','Number/String','0','∞','px, em, %, auto, none',''),
('max-height','Maximum element height','Dimension','Max Height','Layout','Number/String','0','∞','px, em, %, auto, none',''),
('object-position','Position of replaced content','Position','Object Fit','Visual Effects','String','N/A','N/A','x y (e.g., 50% 50%)',''),
('pointer-events','Elements response to mouse events','User Interaction','Events','Interaction','String','N/A','N/A','none, auto',''),
('word-spacing','Spacing between words','Text','Text','Text Styling','Number/String','0','∞','px, em, rem',''),
('border-spacing','Spacing between table cells','Table','Border','Layout','Number/String','0','∞','px, em, rem',''),
('border-collapse','Table cell border behavior','Table','Border','Layout','String','N/A','N/A','separate, collapse',''),
('table-layout','Algorithm used to lay out table cells','Table','Table','Layout','String','N/A','N/A','auto, fixed',''),
('text-indent','Text indent at the first line','Text','Text','Text Styling','Number/String','-∞','∞','px, em, %',''),
('background-size','Size of the background image','Background','Background','Background Styling','String','N/A','N/A','auto, cover, contain, px px',''),
('text-overflow','Overflow handling for inline content','Text','Text','Text Styling','String','N/A','N/A','clip, ellipsis',''),
('resize','Resizability of the element','User Interaction','Resize','Layout','String','N/A','N/A','none, both, horizontal, vertical',''),
('background-repeat','Background image repetition','Background','Background','Background Styling','String','N/A','N/A','repeat, no-repeat, repeat-x, repeat-y',''),
('background-attachment','Background scrolling behavior','Background','Background','Background Styling','String','N/A','N/A','scroll, fixed, local',''),
('font-style','Font style','Font','Text','Text Styling','String','N/A','N/A','normal, italic, oblique',''),
('text-shadow','Text shadow','Shadow','Text','Text Styling','String','N/A','N/A','h-shadow v-shadow blur color',''),
('list-style-image','List item marker image','List','List','List Styling','String','N/A','N/A','none, url()',''),
('list-style-position','Position of list marker','List','List','List Styling','String','N/A','N/A','inside, outside',''),
('caption-side','Position of table caption','Table','Table','Layout','String','N/A','N/A','top, bottom',''),
('counter-reset','Reset CSS counters','Counter','Counter','List Styling','String','N/A','N/A','none, id number',''),
('counter-increment','Increment CSS counters','Counter','Counter','List Styling','String','N/A','N/A','none, id number',''),
('page-break-after','Force a page break after the element','Printing','Page Break','Layout','String','N/A','N/A','auto, always, avoid, left, right',''),
('page-break-before','Force a page break before the element','Printing','Page Break','Layout','String','N/A','N/A','auto, always, avoid, left, right',''),
('break-inside','Page/column/region break inside','Printing','Break','Layout','String','','','',''),
('break-before','Page/column/region break before','Printing','Break','Layout','String','N/A','N/A','auto, avoid, avoid-page',''),
('break-after','Page/column/region break after','Printing','Break','Layout','String','N/A','N/A','auto, avoid, avoid-page',''),
('empty-cells','Display of empty cells in tables','Table','Table','Layout','String','N/A','N/A','show, hide',''),
('column-gap','Gap between columns in a grid','Grid','Grid','Layout','Number/String','0','∞','px, %, em, rem',''),
('row-gap','Gap between rows in a grid','Grid','Grid','Layout','Number/String','0','∞','px, %, em, rem',''),
('gap','Gap between rows and columns in a grid','Grid','Grid','Layout','Number/String','0','∞','px, %, em, rem',''),
('flex-basis','Initial size of a flex item','Flexbox','Flexbox','Layout','Number/String','0','∞','px, %, em, auto',''),
('flex-shrink','Shrink factor of a flex item','Flexbox','Flexbox','Layout','Number','0','∞','Numeric',''),
('flex-grow','Grow factor of a flex item','Flexbox','Flexbox','Layout','Number','0','∞','Numeric',''),
('flex-wrap','Flex items wrapping','Flexbox','Flexbox','Layout','String','N/A','N/A','nowrap, wrap, wrap-reverse',''),
('align-content','Multi-line alignment in Flexbox/Grid','Flexbox/Grid','Flexbox','Layout','String','N/A','N/A','stretch, flex-start, flex-end, center, space-between, space-around',''),
('transform-origin','Transform origin point','Transform','Transform','Visual Effects','String','N/A','N/A','x y z (e.g., 50% 50% 0)',''),
('transform-style','Children elements transform style','Transform','Transform','Visual Effects','String','N/A','N/A','flat, preserve-3d',''),
('perspective','Perspective for child elements','Transform','3D','Visual Effects','Number','0','∞','px',''),
('perspective-origin','Perspective origin for children','Transform','3D','Visual Effects','String','N/A','N/A','x y (e.g., 50% 50%)',''),
('backface-visibility','Backface visibility','Transform','3D','Visual Effects','String','N/A','N/A','visible, hidden',''),
('will-change','Hints browser for optimization','General','Will Change','Visual Effects','String','N/A','N/A','auto, scroll-position, contents, transform',''),
('mask','Masking an element','Mask','Masking','Visual Effects','String','N/A','N/A','url(), none',''),
('box-sizing','Box model','General','Box Sizing','Layout','String','N/A','N/A','content-box, border-box',''),
('filter','Visual effects (e.g., blur, brightness)','Visual Effects','Filter','Visual Effects','String','N/A','N/A','blur(), brightness(), contrast(), grayscale()',''),
('outline-offset','Distance between outline and border/edge','Outline','Outline','Visual Effects','Number','-∞','∞','px',''),
('text-justify','Text justification method','Text','Text','Text Styling','String','N/A','N/A','auto, inter-word, inter-character, none',''),
('touch-action','Touch behavior','User Interaction','Touch','Interaction','String','N/A','N/A','auto, none, pan-x, pan-y',''),
('text-combine-upright','Combines characters horizontally','Text','Text','Text Styling','String','N/A','N/A','none, all',''),
('isolation','Stack context isolation','Position','Isolation','Visual Effects','String','N/A','N/A','auto, isolate',''),
('mix-blend-mode','Blending mode','Visual Effects','Blend Mode','Visual Effects','String','N/A','N/A','normal, multiply, screen, overlay',''),
('writing-mode','Writing direction','Text','Writing','Text Styling','String','N/A','N/A','horizontal-tb, vertical-rl, vertical-lr',''),
('unicode-bidi','Bidi text control','Text','Text','Text Styling','String','N/A','N/A','normal, embed, isolate, bidi-override',''),
('text-orientation','Text orientation in vertical writing','Text','Text','Text Styling','String','N/A','N/A','mixed, upright, sideways',''),
('user-select','User text selection','User Interaction','User Select','Interaction','String','N/A','N/A','auto, none, text, all',''),
('scroll-behavior','Scrolling behavior','User Interaction','Scroll','Interaction','String','N/A','N/A','auto, smooth',''),
('text-rendering','Text rendering optimization','Text','Text','Text Styling','String','N/A','N/A','auto, geometricPrecision, optimizeLegibility',''),
('tab-size','Width of a tab character','Text','Text','Text Styling','Number','0','∞','Numeric',''),
('speak','CSS Speech','Accessibility','Speak','Audio','String','N/A','N/A','none, normal, spell-out',''),
('orphans','Minimum lines at page break','Text','Text','Text Styling','Number','0','∞','Numeric',''),
('widows','Minimum lines at top of new page','Text','Text','Text Styling','Number','0','∞','Numeric',''),
('hyphens','Hyphenation control','Text','Text','Text Styling','String','N/A','N/A','none, manual, auto',''),
('ruby-position','Ruby text position','Text','Ruby','Text Styling','String','N/A','N/A','over, under, inter-character',''),
('ruby-align','Ruby text alignment','Text','Ruby','Text Styling','String','N/A','N/A','start, center, space-between, space-around',''),
('ruby-merge','Ruby text merging','Text','Ruby','Text Styling','String','N/A','N/A','separate, collapse, auto',''),
('text-underline-offset','Text underline offset','Text','Text','Text Styling','Number/String','N/A','N/A','auto, px, em, rem',''),
('text-underline-position','Text underline position','Text','Text','Text Styling','String','N/A','N/A','auto, under, left, right',''),
('overscroll-behavior','Behavior when scrolling past edge','User Interaction','Overscroll','Interaction','String','N/A','N/A','auto, contain, none',''),
('outline-style','Outline style','Outline','Outline','Visual Effects','String','N/A','N/A','none, dotted, dashed, solid, double, groove, ridge, inset, outset',''),
('outline-width','Outline width','Outline','Outline','Visual Effects','Number/String','0','∞','medium, thin, thick, px, em, rem',''),
('outline-color','Outline color','Outline','Outline','Visual Effects','String','N/A','N/A','color names, hex, rgb, rgba, hsl, hsla',''),
('all','Resets all properties','General','All','General','String','N/A','N/A','initial, inherit, unset',''),
('direction','Text direction','Text','Text','Text Styling','String','N/A','N/A','ltr, rtl',''),
('stroke','Stroke color','SVG','Stroke','SVG','String','N/A','N/A','color names, hex, rgb, rgba, hsl, hsla',''),
('stroke-width','Stroke width','SVG','Stroke','SVG','Number','0','∞','px',''),
('stroke-dasharray','Stroke dash pattern','SVG','Stroke','SVG','String','N/A','N/A','Numeric, %',''),
('stroke-dashoffset','Stroke dash offset','SVG','Stroke','SVG','Number','N/A','N/A','px, %',''),
('stroke-linecap','Stroke line cap style','SVG','Stroke','SVG','String','N/A','N/A','butt, round, square',''),
('stroke-linejoin','Stroke line join style','SVG','Stroke','SVG','String','N/A','N/A','miter, round, bevel',''),
('stroke-miterlimit','Stroke miter limit','SVG','Stroke','SVG','Number','0','∞','Numeric',''),
('d','SVG path data','SVG','Path','SVG','String','N/A','N/A','SVG Path Commands',''),
('cx','x-coordinate of SVG circle','SVG','Circle','SVG','Number','N/A','N/A','px',''),
('cy','y-coordinate of SVG circle','SVG','Circle','SVG','Number','N/A','N/A','px',''),
('r','radius of SVG circle','SVG','Circle','SVG','Number','0','∞','px',''),
('x','x-coordinate of SVG rect/text','SVG','Rectangle','SVG','Number','N/A','N/A','px',''),
('y','y-coordinate of SVG rect/text','SVG','Rectangle','SVG','Number','N/A','N/A','px',''),
('rx','x-radius of SVG rect','SVG','Rectangle','SVG','Number','0','∞','px',''),
('ry','y-radius of SVG rect','SVG','Rectangle','SVG','Number','0','∞','px',''),
('viewBox','SVG viewBox','SVG','Viewport','SVG','String','N/A','N/A','Numeric',''),
('preserveAspectRatio','SVG aspect ratio','SVG','Aspect Ratio','SVG','String','N/A','N/A','xMinYMin, xMidYMid, xMaxYMax, etc.',''),
('justify-items','Align grid items along row axis','Grid','Grid','Layout','String','N/A','N/A','start, end, center, stretch',''),
('grid-auto-rows','Auto row size in Grid','Grid','Grid','Layout','String','N/A','N/A','auto, track-size',''),
('grid-auto-columns','Auto column size in Grid','Grid','Grid','Layout','String','N/A','N/A','auto, track-size',''),
('grid-auto-flow','Auto placement algorithm in Grid','Grid','Grid','Layout','String','N/A','N/A','row, column, row dense, column dense',''),
('grid-area','Grid item area','Grid','Grid','Layout','String','N/A','N/A','row-start / column-start / row-end / column-end',''),
('justify-self','Justify self within grid/flex item','Grid/Flexbox','Flexbox','Layout','String','N/A','N/A','auto, normal, stretch, center, start, end',''),
('align-self','Align self within grid/flex item','Grid/Flexbox','Flexbox','Layout','String','N/A','N/A','auto, normal, stretch, center, start, end',''),
('animation-name','Animation name','Animation','Animation','Visual Effects','String','N/A','N/A','none, custom-keyframe-name',''),
('animation-duration','Animation duration','Animation','Animation','Visual Effects','Time','0s','∞','s, ms',''),
('animation-timing-function','Animation timing function','Animation','Animation','Visual Effects','String','N/A','N/A','linear, ease, ease-in, ease-out, ease-in-out',''),
('animation-delay','Animation delay','Animation','Animation','Visual Effects','Time','0s','∞','s, ms',''),
('animation-iteration-count','Animation iteration count','Animation','Animation','Visual Effects','Number/String','0','∞','infinite, number',''),
('animation-direction','Animation direction','Animation','Animation','Visual Effects','String','N/A','N/A','normal, reverse, alternate, alternate-reverse',''),
('animation-fill-mode','Animation fill mode','Animation','Animation','Visual Effects','String','N/A','N/A','none, forwards, backwards, both',''),
('animation-play-state','Animation play state','Animation','Animation','Visual Effects','String','N/A','N/A','running, paused',''),
('transition-property','Transition property','Transition','Transition','Visual Effects','String','N/A','N/A','none, all, property-name',''),
('transition-duration','Transition duration','Transition','Transition','Visual Effects','Time','0s','∞','s, ms',''),
('transition-timing-function','Transition timing function','Transition','Transition','Visual Effects','String','N/A','N/A','linear, ease, ease-in, ease-out, ease-in-out',''),
('transition-delay','Transition delay','Transition','Transition','Visual Effects','Time','0s','∞','s, ms',''),
('image-rendering','Image rendering quality','Rendering','Image','Visual Effects','String','N/A','N/A','auto, crisp-edges, pixelated',''),
('clip','Deprecated clipping','Deprecated','Clipping','Visual Effects','String','N/A','N/A','rect()',''),
('azimuth','Deprecated sound direction','Deprecated','Audio','Audio','String','N/A','N/A','angle, identifiers',''),
('elevation','Deprecated sound elevation','Deprecated','Audio','Audio','String','N/A','N/A','angle, identifiers','');

-- create table for widget_theme_styles_master for mysql
CREATE TABLE widget_theme_styles_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    theme_id INT,
    style_id INT,
    style_value VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (theme_id) REFERENCES widget_themes_master(id),
    FOREIGN KEY (style_id) REFERENCES widget_styles_master(id),
    UNIQUE (theme_id, style_id),
    INDEX (id)
);

-- create table for widget_effects_styles_master for mysql
CREATE TABLE widget_effects_styles_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    effect_id INT NOT NULL,
    theme_id INT NULL DEFAULT NULL,
    style_id INT NOT NULL,
    style_value VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (effect_id) REFERENCES widget_effects_master(id),
    FOREIGN KEY (style_id) REFERENCES widget_styles_master(id),
    FOREIGN KEY (theme_id) REFERENCES widget_themes_master(id),
    UNIQUE (effect_id, style_id),
    INDEX (id)
);

-- create widget_template_types_master for mysql
CREATE TABLE widget_template_types_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    template_html TEXT,
    template_js TEXT,
    template_links TEXT,
    template_scripts TEXT,
    industry_id INT DEFAULT null,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    UNIQUE (name),
    INDEX (id)
);

-- insert values in template types table
INSERT INTO widget_template_types_master (name, description)
VALUES
    ('Admin Dashboard', 'Template designed for building web applications with data visualization and management features.'),
    ('E-commerce', 'Template tailored for online stores and marketplaces, featuring product listings, shopping carts, and checkout processes.'),
    ('Portfolio', 'Template ideal for showcasing creative works such as photography, art, or design portfolios.'),
    ('Landing Page', 'Template designed for creating effective landing pages for marketing campaigns or product launches.'),
    ('Blog', 'Template tailored for bloggers and content creators, featuring article layouts and comment sections.'),
    ('Mobile App', 'Template designed for building mobile applications, optimized for iOS, Android, or cross-platform development.'),
    ('One-page', 'Template featuring all content on a single scrolling page, suitable for small websites or promotional pages.'),
    ('Multi-page', 'Traditional website template consisting of multiple interconnected pages for larger websites with diverse content.'),
    ('SaaS', 'Template designed for building software-as-a-service (SaaS) applications, featuring user authentication and subscription management.'),
    ('Corporate', 'Template suitable for corporate websites or business profiles, featuring company information and team profiles.'),
    ('Resume/CV', 'Template designed for creating digital resumes or curriculum vitae (CV) websites.'),
    ('Real Estate', 'Template tailored for real estate agencies or property listings, featuring property search and listings with photos and details.'),
    ('Event', 'Template designed for event websites or promotional pages, featuring event details and registration forms.'),
    ('Restaurant', 'Template tailored for restaurant websites, featuring menus, reservations, and reviews.'),
    ('Education', 'Template designed for educational institutions or e-learning platforms, featuring course listings and enrollment forms.'),
    ('Travel', 'Template suitable for travel agencies or tour operators, featuring destination guides and booking forms.'),
    ('Fitness', 'Template designed for fitness centers or personal trainers, featuring workout schedules and membership options.'),
    ('Music', 'Template tailored for musicians or bands, featuring discography, tour dates, and music players.'),
    ('Medical', 'Template suitable for medical clinics or healthcare providers, featuring appointment scheduling and patient information.'),
    ('Fashion', 'Template designed for fashion brands or clothing stores, featuring lookbooks and product catalogs.'),
    ('Technology', 'Template tailored for technology companies or startups, featuring product showcases and technical documentation.'),
    ('Art', 'Template designed for artists or art galleries, featuring portfolios and exhibition schedules.'),
    ('Photography', 'Template tailored for photographers or photography studios, featuring galleries and client galleries.'),
    ('Wedding', 'Template designed for wedding websites or event planning, featuring RSVP forms and photo galleries.'),
    ('Gaming', 'Template suitable for gaming communities or esports teams, featuring forums and gaming event schedules.'),
    ('Legal', 'Template designed for law firms or legal professionals, featuring practice areas and attorney profiles.'),
    ('Nonprofit', 'Template tailored for nonprofit organizations or charities, featuring donation forms and volunteer opportunities.'),
    ('Interior Design', 'Template designed for interior designers or home decor businesses, featuring portfolios and design consultations.'),
    ('Automotive', 'Template suitable for car dealerships or automotive businesses, featuring vehicle listings and test drive requests.'),
    ('Pet Care', 'Template tailored for pet care services or animal shelters, featuring adoption listings and pet care tips.'),
    ('Food Delivery', 'Template designed for food delivery services or meal kit subscriptions, featuring menu listings and delivery options.'),
    ('Startup', 'Template suitable for startups or entrepreneurial ventures, featuring product launches and investor information.'),
    ('Cryptocurrency', 'Template tailored for cryptocurrency exchanges or blockchain startups, featuring trading interfaces and cryptocurrency listings.'),
    ('Health & Wellness', 'Template designed for health and wellness businesses, featuring wellness programs and lifestyle tips.'),
    ('Freelancer', 'Template suitable for freelancers or independent professionals, featuring portfolio showcases and client testimonials.'),
    ('Social Network', 'Template tailored for social networking platforms or online communities, featuring user profiles and social feeds.'),
    ('Beauty', 'Template designed for beauty salons or cosmetic brands, featuring beauty services and appointment bookings.'),
    ('Environmental', 'Template suitable for environmental organizations or eco-friendly businesses, featuring sustainability initiatives and environmental campaigns.'),
    ('Crafts & DIY', 'Template tailored for crafts enthusiasts or DIY projects, featuring project tutorials and crafting supplies.'),
    ('Sports', 'Template designed for sports teams or athletic organizations, featuring game schedules and player profiles.'),
    ('Real Estate Agency', 'Template suitable for real estate agencies or property management companies, featuring property listings and agent profiles.'),
    ('Event Planning', 'Template tailored for event planning businesses or event coordinators, featuring event packages and planning tools.'),
    ('Technology Blog', 'Template designed for technology blogs or tech news websites, featuring articles and product reviews.'),
    ('Personal Blog', 'Template suitable for personal blogs or lifestyle bloggers, featuring articles and personal reflections.'),
    ('Creative Agency', 'Template tailored for creative agencies or design studios, featuring client projects and creative portfolios.'),
    ('Parenting', 'Template designed for parenting blogs or family-oriented websites, featuring parenting tips and family activities.'),
    ('Freight & Logistics', 'Template suitable for freight forwarding companies or logistics providers, featuring shipment tracking and logistics solutions.'),
    ('Education Blog', 'Template tailored for education blogs or educational resources, featuring articles and learning materials.'),
    ('Marketing Agency', 'Template designed for marketing agencies or digital marketing firms, featuring client campaigns and marketing strategies.'),
    ('Political Campaign', 'Template suitable for political campaigns or election websites, featuring candidate profiles and campaign updates.'),
    ('Financial Services', 'Template tailored for financial institutions or investment firms, featuring financial planning tools and investment advice.'),
    ('Gardening', 'Template designed for gardening enthusiasts or landscaping businesses, featuring gardening tips and plant care guides.'),
    ('Travel Blog', 'Template suitable for travel blogs or travel journals, featuring travel stories and destination guides.'),
    ('Job Board', 'Template tailored for job boards or recruitment platforms, featuring job listings and candidate profiles.'),
    ('Recipe', 'Template designed for recipe websites or cooking blogs, featuring recipe collections and cooking tutorials.'),
    ('Vlogging', 'Template suitable for vloggers or video content creators, featuring video playlists and channel subscriptions.'),
    ('Podcast', 'Template tailored for podcasters or audio content creators, featuring episode archives and subscription options.'),
    ('Review', 'Template designed for review websites or product review blogs, featuring user ratings and reviews.'),
    ('Fitness Blog', 'Template suitable for fitness blogs or health enthusiasts, featuring workout routines and fitness tips.'),
    ('Fashion Blog', 'Template tailored for fashion blogs or style influencers, featuring fashion trends and style guides.'),
    ('Art Blog', 'Template designed for art blogs or art enthusiasts, featuring art collections and artist interviews.'),
    ('Music Blog', 'Template suitable for music blogs or music enthusiasts, featuring album reviews and artist spotlights.'),
    ('Medical Blog', 'Template tailored for medical blogs or healthcare professionals, featuring health advice and medical research.'),
    ('Travel Agency', 'Template designed for travel agencies or tour operators, featuring travel packages and destination guides.'),
    ('Fitness Tracker', 'Template designed for fitness tracking apps or devices, featuring workout logs and activity tracking.'),
    ('Recipe App', 'Template suitable for recipe apps or cooking enthusiasts, featuring recipe collections and cooking tutorials.'),
    ('Music Streaming', 'Template tailored for music streaming services or music apps, featuring playlists and music recommendations.'),
    ('Language Learning', 'Template designed for language learning apps or platforms, featuring language courses and vocabulary exercises.'),
    ('Finance Tracker', 'Template suitable for finance tracking apps or budgeting tools, featuring expense tracking and financial reports.'),
    ('Task Management', 'Template tailored for task management apps or to-do lists, featuring task organization and productivity tools.'),
    ('Social Media Analytics', 'Template designed for social media analytics tools or platforms, featuring user engagement metrics and audience insights.'),
    ('HR Management', 'Template suitable for human resources management software or HR platforms, featuring employee records and payroll management.'),
    ('Appointment Scheduler', 'Template tailored for appointment scheduling apps or booking platforms, featuring availability calendars and appointment reminders.'),
    ('Inventory Management', 'Template designed for inventory management software or warehouse management systems, featuring stock tracking and inventory alerts.'),
    ('Customer Relationship Management (CRM)', 'Template suitable for CRM software or customer management platforms, featuring contact management and sales pipelines.'),
    ('Project Management', 'Template tailored for project management software or collaboration tools, featuring project timelines and task assignments.'),
    ('Event Management', 'Template designed for event management software or event planning platforms, featuring event registration and ticketing.'),
    ('Survey Tool', 'Template suitable for survey creation tools or polling platforms, featuring survey templates and response analysis.'),
    ('Email Marketing', 'Template tailored for email marketing software or email campaign management, featuring email templates and subscriber lists.'),
    ('Learning Management System (LMS)', 'Template designed for learning management systems or educational platforms, featuring course authoring and student enrollment.'),
    ('Document Management', 'Template suitable for document management software or document collaboration platforms, featuring file sharing and version control.'),
    ('Billing & Invoicing', 'Template tailored for billing and invoicing software or billing platforms, featuring invoice generation and payment tracking.'),
    ('Customer Support Ticketing', 'Template designed for customer support ticketing systems or helpdesk software, featuring ticket queues and issue tracking.'),
    ('Appointment Booking', 'Template suitable for appointment booking apps or scheduling platforms, featuring real-time availability and booking confirmations.'),
    ('Property Management', 'Template tailored for property management software or real estate management platforms, featuring tenant management and lease tracking.'),
    ('Content Management System (CMS)', 'Template designed for content management systems or website builders, featuring content publishing and website customization.'),
    ('Chat Application', 'Template suitable for chat applications or messaging platforms, featuring real-time messaging and group chat functionality.'),
    ('E-learning Platform', 'Template tailored for e-learning platforms or online education portals, featuring course catalogs and learning resources.'),
    ('Event Ticketing', 'Template designed for event ticketing platforms or online ticket sales, featuring event listings and ticket purchasing.'),
    ('Job Portal', 'Template suitable for job portals or recruitment websites, featuring job listings and candidate profiles.'),
    ('Appointment Reminder', 'Template tailored for appointment reminder apps or scheduling assistants, featuring automated reminders and calendar integration.'),
    ('Expense Tracker', 'Template designed for expense tracking apps or personal finance tools, featuring expense categorization and budget analysis.'),
    ('Subscription Management', 'Template suitable for subscription management platforms or subscription billing systems, featuring subscription plans and recurring payments.'),
    ('Travel Planning', 'Template tailored for travel planning apps or itinerary planners, featuring trip planning and travel recommendations.'),
    ('Medical Records Management', 'Template designed for medical records management systems or electronic health records (EHR) platforms, featuring patient records and medical history.'),
    ('Appointment Scheduling', 'Template suitable for appointment scheduling software or booking systems, featuring appointment calendars and availability checks.'),
    ('Workout Planner', 'Template tailored for workout planning apps or fitness planners, featuring exercise routines and workout schedules.'),
    ('Personal Finance Management', 'Template designed for personal finance management apps or budget trackers, featuring expense tracking and financial goal setting.'),
    ('Recipe Organizer', 'Template suitable for recipe organization apps or cooking planners, featuring recipe collections and meal planning.'),
    ('Language Translation', 'Template tailored for language translation apps or translation services, featuring text translation and language detection.'),
    ('Stock Market Analysis', 'Template designed for stock market analysis tools or investment platforms, featuring stock charts and market insights.'),
    ('Home Automation Control', 'Template suitable for home automation control apps or smart home systems, featuring device control and automation settings.'),
    ('Event Registration', 'Template tailored for event registration systems or attendee management, featuring event sign-ups and ticketing.'),
    ('Social Networking Platform', 'Template designed for social networking platforms or community websites, featuring user profiles and social feeds.'),
    ('Expense Management', 'Template suitable for expense management apps or spending trackers, featuring expense categorization and budget management.'),
    ('Travel Expense Tracking', 'Template tailored for travel expense tracking apps or travel budget planners, featuring trip expenses and travel cost analysis.'),
    ('Employee Onboarding', 'Template designed for employee onboarding software or HR platforms, featuring new hire forms and employee training.'),
    ('Customer Feedback Collection', 'Template suitable for customer feedback collection tools or survey platforms, featuring feedback forms and response analysis.'),
    ('Project Collaboration', 'Template tailored for project collaboration tools or team communication platforms, featuring project boards and task assignments.'),
    ('Health & Fitness Tracker', 'Template designed for health and fitness tracking apps or wearables, featuring activity logs and health statistics.'),
    ('Personal Organizer', 'Template suitable for personal organizer apps or productivity tools, featuring task lists and calendar integration.'),
    ('Task Tracking', 'Template tailored for task tracking apps or project management systems, featuring task boards and progress tracking.'),
    ('Event Planning & Management', 'Template designed for event planning and management software or event management platforms, featuring event planning tools and attendee management.'),
    ('Social Media Management', 'Template suitable for social media management tools or social media scheduling platforms, featuring social media calendars and content scheduling.'),
    ('Recipe Sharing', 'Template tailored for recipe sharing platforms or cooking communities, featuring recipe sharing and user ratings.'),
    ('Learning Management', 'Template designed for learning management systems (LMS) or online education platforms, featuring course management and student progress tracking.'),
    ('Budget Planning', 'Template suitable for budget planning apps or financial planning tools, featuring budget creation and expense tracking.'),
    ('Inventory Tracking', 'Template tailored for inventory tracking systems or warehouse management software, featuring inventory management and stock control.'),
    ('Contact Management', 'Template designed for contact management apps or CRM systems, featuring contact lists and communication tracking.'),
    ('Appointment Management', 'Template suitable for appointment management software or scheduling systems, featuring appointment calendars and booking management.'),
    ('Event Promotion', 'Template tailored for event promotion websites or event marketing platforms, featuring event listings and promotional tools.'),
    ('Document Collaboration', 'Template designed for document collaboration tools or cloud storage platforms, featuring document sharing and collaborative editing.'),
    ('Health Monitoring', 'Template suitable for health monitoring apps or medical tracking devices, featuring health data tracking and medical alerts.'),
    ('Expense Tracking', 'Template tailored for expense tracking apps or financial management tools, featuring expense categorization and spending analysis.'),
    ('Project Planning', 'Template designed for project planning apps or project management platforms, featuring project timelines and task allocation.'),
    ('Event Ticket Sales', 'Template suitable for event ticket sales platforms or ticketing systems, featuring event ticket listings and ticket purchasing.'),
    ('Appointment Booking & Management', 'Template tailored for appointment booking and management systems or scheduling apps, featuring appointment scheduling and customer management.'),
    ('Workout Tracking', 'Template designed for workout tracking apps or fitness trackers, featuring exercise logs and workout analytics.'),
    ('Personal Budgeting', 'Template suitable for personal budgeting apps or expense trackers, featuring budget planning and financial goal setting.'),
    ('Recipe Management', 'Template tailored for recipe management apps or cooking organizers, featuring recipe collections and meal planning tools.'),
    ('Language Learning & Translation', 'Template designed for language learning and translation apps or language learning platforms, featuring language courses and translation tools.'),
    ('Stock Portfolio Management', 'Template suitable for stock portfolio management apps or investment trackers, featuring portfolio analysis and investment tracking.'),
    ('Home Automation Control & Monitoring', 'Template tailored for home automation control and monitoring systems or smart home hubs, featuring device control and home monitoring.'),
    ('Event Planning & Registration', 'Template designed for event planning and registration software or event management platforms, featuring event planning tools and attendee registration.'),
    ('Social Networking & Community Building', 'Template suitable for social networking and community building platforms or online communities, featuring user profiles and community forums.'),
    ('Expense Reporting', 'Template tailored for expense reporting apps or expense management systems, featuring expense tracking and reporting tools.'),
    ('Project Management & Collaboration', 'Template designed for project management and collaboration tools or team communication platforms, featuring project boards and task collaboration.'),
    ('Health & Fitness Monitoring', 'Template suitable for health and fitness monitoring apps or wearable fitness trackers, featuring health data tracking and fitness analytics.'),
    ('Personal Productivity', 'Template tailored for personal productivity apps or task management tools, featuring task lists and productivity trackers.'),
    ('Task Management & Collaboration', 'Template designed for task management and collaboration apps or team productivity platforms, featuring task lists and team collaboration tools.'),
    ('Event Marketing', 'Template suitable for event marketing websites or event promotion platforms, featuring event listings and promotional campaigns.'),
    ('Document Management & Collaboration', 'Template tailored for document management and collaboration tools or cloud storage platforms, featuring document sharing and collaborative editing.'),
    ('Health & Wellness Tracking', 'Template designed for health and wellness tracking apps or fitness trackers, featuring health data tracking and wellness insights.'),
    ('Expense Management & Budgeting', 'Template suitable for expense management and budgeting apps or financial planning tools, featuring expense tracking and budget management.'),
    ('Project Planning & Management', 'Template tailored for project planning and management software or project management platforms, featuring project timelines and task management.'),
    ('Event Ticketing & Registration', 'Template designed for event ticketing and registration platforms or online ticket sales, featuring event ticket listings and attendee registration.'),
    ('Appointment Scheduling & Management', 'Template suitable for appointment scheduling and management systems or booking apps, featuring appointment calendars and customer management.');

-- create table for widget_templates_type_styles_master for mysql
CREATE TABLE widget_templates_type_styles_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    template_type_id INT,
    style_id INT,
    style_value VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (template_type_id) REFERENCES widget_template_types_master(id),
    FOREIGN KEY (style_id) REFERENCES widget_styles_master(id),
    UNIQUE (template_type_id, style_id),
    INDEX (id)
);

-- create table for widget_templates_type_styles_master for mysql
CREATE TABLE widget_templates_type_themes_master (
    id INT AUTO_INCREMENT PRIMARY KEY,
    template_type_id INT,
    theme_id INT,
    theme_style_id INT,
    theme_style_value VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT DEFAULT 0,
    updated_by INT DEFAULT 0,
    FOREIGN KEY (template_type_id) REFERENCES widget_template_types_master(id),
    FOREIGN KEY (theme_id) REFERENCES widget_themes_master(id),
    FOREIGN KEY (theme_style_id) REFERENCES widget_styles_master(id),
    UNIQUE (template_type_id, theme_id, theme_style_id),
    INDEX (id)
);