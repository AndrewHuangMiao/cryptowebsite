interface TestimonialsProps {
  // Add any props if needed
}

const Testimonials: React.FC<TestimonialsProps> = () => {
  return (
    <section id="testimonials" className="testimonials section">
      <div className="container">
        <h2 className="section-title">What our customers are saying!</h2>
        <div className="testimonial-grid">
          <div className="testimonial-card">
            <p className="testimonial-text">"I cannot express how pleased I am with the community management service provided by Skyline. The team's dedication and expertise have truly set them apart, and I'm thrilled to share my positive experience."</p>
            <div className="testimonial-author">
              <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Ryan Wang" className="author-image" />
              <div className="author-info">
                <h4>Ryan Wang</h4>
                <p>Business Development Manager, KuCoin</p>
              </div>
            </div>
          </div>
          <div className="testimonial-card">
            <p className="testimonial-text">"We've seen our fair share of community management services. However, our experience with Skyline's community management service has been nothing short of exceptional. In an industry where trust and community are paramount, Skyline shines brightly."</p>
            <div className="testimonial-author">
              <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Alex Li" className="author-image" />
              <div className="author-info">
                <h4>Alex Li</h4>
                <p>Business Development Manager, Bitget</p>
              </div>
            </div>
          </div>
          <div className="testimonial-card">
            <p className="testimonial-text">"Skyline makes our life easier with their English-language live chat service available 24/7 to answer any questions our customers may have. I always wake up with a great sigh of relief knowing that a competent support team will provide immediate resolution."</p>
            <div className="testimonial-author">
              <img src="https://randomuser.me/api/portraits/men/67.jpg" alt="Maikel Saris" className="author-image" />
              <div className="author-info">
                <h4>Maikel Saris</h4>
                <p>Operations Manager, CheapestGameCards</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Testimonials; 