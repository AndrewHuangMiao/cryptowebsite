interface FooterProps {
  // Add any props if needed
}

const Footer: React.FC<FooterProps> = () => {
  return (
    <footer className="footer">
      <div className="container footer-container">
        <div>
          <div className="footer-logo">Skyline Support</div>
          <div className="footer-contact">
            <p>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 13C12.5523 13 13 12.5523 13 12C13 11.4477 12.5523 11 12 11C11.4477 11 11 11.4477 11 12C11 12.5523 11.4477 13 12 13Z" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                <path d="M12 22C16 18 20 14.4183 20 10C20 5.58172 16.4183 2 12 2C7.58172 2 4 5.58172 4 10C4 14.4183 8 18 12 22Z" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
              203 Skyline Live Support, A. Mabini corner E. Jacinto, Brgy. 5 (Sangandaan), Caloocan City 1400, Metro Manila, Philippines
            </p>
            <p>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M22 6C22 5 21 4 20 4H4C3 4 2 5 2 6V18C2 19 3 20 4 20H20C21 20 22 19 22 18V6ZM20 6L12 11L4 6H20ZM20 18H4V8L12 13L20 8V18Z" fill="white"/>
              </svg>
              business@skyline.support
            </p>
            <p>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M22 16.92V19.92C22 20.4704 21.7893 20.9996 21.4142 21.3747C21.0391 21.7498 20.5099 21.9605 19.96 21.96C18.2 22.09 16.48 21.89 14.87 21.37C13.33 20.88 11.89 20.08 10.6 19C9.37 17.93 8.3 16.68 7.46 15.31C6.59 13.55 6.05 11.64 6 9.7C5.99955 9.15007 6.21024 8.62093 6.58517 8.24599C6.96011 7.87106 7.48926 7.66037 8.04 7.66H11.04C11.5104 7.65995 11.9649 7.82854 12.3149 8.13331C12.6649 8.43808 12.8855 8.85834 12.93 9.32C13.02 10.27 13.22 11.2 13.53 12.08C13.6573 12.4278 13.6692 12.8068 13.5644 13.1623C13.4596 13.5177 13.2435 13.8322 12.95 14.06L11.7 15.31C12.4667 16.5434 13.4334 17.6501 14.56 18.59L15.81 17.34C16.0378 17.0465 16.3523 16.8304 16.7077 16.7256C17.0632 16.6208 17.4422 16.6327 17.79 16.76C18.67 17.07 19.6 17.27 20.55 17.36C21.0216 17.4045 21.4419 17.6251 21.7467 17.9751C22.0514 18.3251 22.22 18.7796 22.22 19.25L22 16.92Z" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
              +63 966 798 3112 (WhatsApp)
            </p>
          </div>
        </div>
        <div>
          <h3 className="footer-heading">Company</h3>
          <ul className="footer-links">
            <li><a href="#">About Us</a></li>
            <li><a href="#">Case Study</a></li>
            <li><a href="#">Blogs</a></li>
            <li><a href="#">Contact Us</a></li>
          </ul>
        </div>
        <div>
          <h3 className="footer-heading">Services</h3>
          <ul className="footer-links">
            <li><a href="#">Customer Support</a></li>
            <li><a href="#">Community Development</a></li>
            <li><a href="#">Crypto Promotion Services</a></li>
          </ul>
        </div>
        <div>
          <h3 className="footer-heading">Legal</h3>
          <ul className="footer-links">
            <li><a href="#">Terms Of Use</a></li>
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Disclaimer</a></li>
          </ul>
        </div>
      </div>
      <div className="footer-bottom">
        <div className="container">
          <p>© {new Date().getFullYear()} Skyline. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer; 