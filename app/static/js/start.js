// Get the navbar element
const navbar = document.getElementById('navbar');

// Function to change navbar color on scroll
function changeNavbarColorOnScroll() {
    if (window.scrollY > 50) {  // Adjust the scroll position to your preference
        navbar.classList.add('scrolled');  // Add class to change color
    } else {
        navbar.classList.remove('scrolled');  // Remove class to revert back
    }
}

// Add scroll event listener to call the function when scrolling
window.addEventListener('scroll', changeNavbarColorOnScroll);
