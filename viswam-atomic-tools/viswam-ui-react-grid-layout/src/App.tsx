import './App.css'
import Layout from './Layout'

function App() {

  return (
      <div style={{ width: '100vw', height: '100vh' }}>
      <Layout layout={[{ i: "a", x: 0, y: 0, w: 1, h: 2 }, 
        { i: "b", x: 1, y: 2, w: 3, h: 2 }, 
        { i: "c", x: 4, y: 1, w: 4, h: 2 },
        { i: "d", x: 8, y: 0, w: 4, h: 2 }, 
        { i: "e", x: 0, y: 3, w: 12, h: 2 }]}/>
      </div>
  )
}

export default App
