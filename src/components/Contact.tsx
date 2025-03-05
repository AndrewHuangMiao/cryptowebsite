import { useState } from 'react';

interface ContactProps {
  // Add any props if needed
}

const Contact: React.FC<ContactProps> = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    company: '',
    message: ''
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Handle form submission here
    console.log('Form submitted:', formData);
    // Reset form
    setFormData({
      name: '',
      email: '',
      company: '',
      message: ''
    });
    // Show success message
    alert('Thank you for your message! We will get back to you soon.');
  };

  return (
    <section id="contact" className="contact section">
      <div className="container">
        <h2 className="section-title">Get in Touch</h2>
        <div className="contact-container">
          <div className="contact-info">
            <h3>Ready to elevate your business?</h3>
            <p>Fill out the form and our team will get back to you within 24 hours.</p>
            <div className="contact-methods">
              <div className="contact-method">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M22 6C22 5 21 4 20 4H4C3 4 2 5 2 6V18C2 19 3 20 4 20H20C21 20 22 19 22 18V6ZM20 6L12 11L4 6H20ZM20 18H4V8L12 13L20 8V18Z" fill="currentColor"/>
                </svg>
                <span>business@skyline.support</span>
              </div>
              <div className="contact-method">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M22 16.92V19.92C22 20.4704 21.7893 20.9996 21.4142 21.3747C21.0391 21.7498 20.5099 21.9605 19.96 21.96C18.2 22.09 16.48 21.89 14.87 21.37C13.33 20.88 11.89 20.08 10.6 19C9.37 17.93 8.3 16.68 7.46 15.31C6.59 13.55 6.05 11.64 6 9.7C5.99955 9.15007 6.21024 8.62093 6.58517 8.24599C6.96011 7.87106 7.48926 7.66037 8.04 7.66H11.04C11.5104 7.65995 11.9649 7.82854 12.3149 8.13331C12.6649 8.43808 12.8855 8.85834 12.93 9.32C13.02 10.27 13.22 11.2 13.53 12.08C13.6573 12.4278 13.6692 12.8068 13.5644 13.1623C13.4596 13.5177 13.2435 13.8322 12.95 14.06L11.7 15.31C12.4667 16.5434 13.4334 17.6501 14.56 18.59L15.81 17.34C16.0378 17.0465 16.3523 16.8304 16.7077 16.7256C17.0632 16.6208 17.4422 16.6327 17.79 16.76C18.67 17.07 19.6 17.27 20.55 17.36C21.0216 17.4045 21.4419 17.6251 21.7467 17.9751C22.0514 18.3251 22.22 18.7796 22.22 19.25L22 16.92Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
                <span>+63 966 798 3112 (WhatsApp)</span>
              </div>
            </div>
          </div>
          <div className="contact-form">
            <form onSubmit={handleSubmit}>
              <div className="form-group">
                <label htmlFor="name">Name</label>
                <input 
                  type="text" 
                  id="name" 
                  name="name" 
                  value={formData.name}
                  onChange={handleChange}
                  required 
                />
              </div>
              <div className="form-group">
                <label htmlFor="email">Email</label>
                <input 
                  type="email" 
                  id="email" 
                  name="email" 
                  value={formData.email}
                  onChange={handleChange}
                  required 
                />
              </div>
              <div className="form-group">
                <label htmlFor="company">Company</label>
                <input 
                  type="text" 
                  id="company" 
                  name="company" 
                  value={formData.company}
                  onChange={handleChange}
                />
              </div>
              <div className="form-group">
                <label htmlFor="message">Message</label>
                <textarea 
                  id="message" 
                  name="message" 
                  rows={5}
                  value={formData.message}
                  onChange={handleChange}
                  required
                ></textarea>
              </div>
              <button type="submit" className="btn btn-primary">Send Message</button>
            </form>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Contact; 