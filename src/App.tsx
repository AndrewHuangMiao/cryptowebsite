import './App.css'
import Header from './components/Header'
import Hero from './components/Hero'
import Services from './components/Services'
import Testimonials from './components/Testimonials'
import CaseStudies from './components/CaseStudies'
import Blog from './components/Blog'
import Contact from './components/Contact'
import Footer from './components/Footer'

function App() {
  return (
    <div className="app">
      <Header />
      <Hero />
      <Services />
      <Testimonials />
      <CaseStudies />
      <Blog />
      <Contact />
      <Footer />
    </div>
  )
}

export default App
