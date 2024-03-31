/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./StayScape/StayScape/*.{aspx,Master}"],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}

