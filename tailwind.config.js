/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./StayScape/StayScape/*.{aspx,Master}", "./StayScape/StayScape/errors/*.{aspx,Master}"],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}

