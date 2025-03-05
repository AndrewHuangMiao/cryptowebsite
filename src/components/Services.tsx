interface ServiceProps {
  // Add any props if needed
}

const Services: React.FC<ServiceProps> = () => {
  return (
    <section id="services" className="services section">
      <div className="container">
        <h2 className="section-title">Our Services</h2>
        <div className="services-grid">
          <div className="service-card">
            <div className="service-icon">💬</div>
            <h3 className="service-title">Customer Support</h3>
            <p className="service-description">Multi-channel support—calls, email, live chat, and troubleshooting—speeds resolutions, boosts satisfaction, and keeps customers coming back.</p>
            <a href="#" className="btn btn-secondary">Learn More</a>
          </div>
          <div className="service-card">
            <div className="service-icon">👥</div>
            <h3 className="service-title">Community Building</h3>
            <p className="service-description">Around-the-clock moderation, engaging community activities, and quality content creation to keep users involved, elevate app store ratings, and strengthen brand loyalty.</p>
            <a href="#" className="btn btn-secondary">Learn More</a>
          </div>
          <div className="service-card">
            <div className="service-icon">📈</div>
            <h3 className="service-title">Targeted Promotion</h3>
            <p className="service-description">We create targeted hype campaigns, proactively manage ratings and reviews, and leverage trending topics to drive brand visibility and spark user engagement.</p>
            <a href="#" className="btn btn-secondary">Learn More</a>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Services; 