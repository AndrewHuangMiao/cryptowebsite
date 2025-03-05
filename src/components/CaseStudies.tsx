interface CaseStudiesProps {
  // Add any props if needed
}

const CaseStudies: React.FC<CaseStudiesProps> = () => {
  return (
    <section id="case-studies" className="case-studies section">
      <div className="container">
        <h2 className="section-title">Case Studies</h2>
        <div className="case-studies-grid">
          <div className="case-study-card">
            <div className="case-study-image">
              <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="KuCoin Case Study" />
            </div>
            <div className="case-study-content">
              <h3 className="case-study-title">KuCoin</h3>
              <p className="case-study-description">How we helped KuCoin improve their customer satisfaction score by 45% through implementing 24/7 multilingual support and community management.</p>
              <div className="case-study-stats">
                <div className="case-stat">
                  <span className="case-stat-number">45%</span>
                  <span className="case-stat-label">Increase in CSAT</span>
                </div>
                <div className="case-stat">
                  <span className="case-stat-number">30%</span>
                  <span className="case-stat-label">Reduction in response time</span>
                </div>
              </div>
              <a href="#" className="btn btn-secondary">Read Case Study</a>
            </div>
          </div>
          
          <div className="case-study-card">
            <div className="case-study-image">
              <img src="https://images.unsplash.com/photo-1639322537228-f710d846310a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80" alt="Bitget Case Study" />
            </div>
            <div className="case-study-content">
              <h3 className="case-study-title">Bitget</h3>
              <p className="case-study-description">How our community management strategies helped Bitget grow their Telegram community from 5,000 to 50,000 members in just 6 months.</p>
              <div className="case-study-stats">
                <div className="case-stat">
                  <span className="case-stat-number">900%</span>
                  <span className="case-stat-label">Community growth</span>
                </div>
                <div className="case-stat">
                  <span className="case-stat-number">65%</span>
                  <span className="case-stat-label">Increase in engagement</span>
                </div>
              </div>
              <a href="#" className="btn btn-secondary">Read Case Study</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default CaseStudies; 