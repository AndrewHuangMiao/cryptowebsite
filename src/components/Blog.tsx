interface BlogProps {
  // Add any props if needed
}

const Blog: React.FC<BlogProps> = () => {
  return (
    <section id="blog" className="blog section">
      <div className="container">
        <h2 className="section-title">Latest from Our Blog</h2>
        <div className="blog-grid">
          <div className="blog-card">
            <div className="blog-image">
              <img src="https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Customer Support Strategies" />
            </div>
            <div className="blog-content">
              <div className="blog-date">May 15, 2023</div>
              <h3 className="blog-title">5 Customer Support Strategies That Will Boost Your Retention</h3>
              <p className="blog-excerpt">Learn how implementing these five customer support strategies can significantly improve your customer retention rates and boost your business growth.</p>
              <a href="#" className="blog-link">Read More</a>
            </div>
          </div>
          
          <div className="blog-card">
            <div className="blog-image">
              <img src="https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2074&q=80" alt="Community Building" />
            </div>
            <div className="blog-content">
              <div className="blog-date">April 28, 2023</div>
              <h3 className="blog-title">The Art of Community Building in the Digital Age</h3>
              <p className="blog-excerpt">Discover the essential elements of building a thriving online community that engages users and creates brand advocates for your business.</p>
              <a href="#" className="blog-link">Read More</a>
            </div>
          </div>
          
          <div className="blog-card">
            <div className="blog-image">
              <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2015&q=80" alt="Marketing Strategies" />
            </div>
            <div className="blog-content">
              <div className="blog-date">March 12, 2023</div>
              <h3 className="blog-title">Innovative Marketing Strategies for Crypto Projects</h3>
              <p className="blog-excerpt">Explore cutting-edge marketing strategies specifically designed for cryptocurrency and blockchain projects to stand out in a competitive market.</p>
              <a href="#" className="blog-link">Read More</a>
            </div>
          </div>
        </div>
        <div className="blog-cta">
          <a href="#" className="btn btn-primary">View All Articles</a>
        </div>
      </div>
    </section>
  );
};

export default Blog; 