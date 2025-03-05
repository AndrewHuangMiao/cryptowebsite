interface HeroProps {
  // Add any props if needed
}

const Hero: React.FC<HeroProps> = () => {
  return (
    <section className="hero">
      <div className="container hero-container">
        <div className="hero-content">
          <h1 className="hero-title">You are competing with over 300 million businesses worldwide</h1>
          <h2 className="hero-subtitle">How will you stand out?</h2>
          <p>It's simple—secure dependable customer support, grow your brand with proven community growth strategies, and strengthen your presence with expert online reputation management across all digital platforms.</p>
          <div className="hero-stats">
            <div className="stat">
              <div className="stat-number">54,000+</div>
              <div className="stat-label">Partners and customers around the globe</div>
            </div>
          </div>
          <a href="#services" className="btn btn-primary">See How We Make It Happen</a>
        </div>
        <div className="hero-image">
          <img src="/hero-image.svg" alt="Skyline Support Services" />
        </div>
      </div>
    </section>
  );
};

export default Hero; 