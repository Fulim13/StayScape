/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./StayScape/StayScape/*.{aspx,Master}", "./StayScape/StayScape/errors/*.{aspx,Master}","./StayScape/StayScape/Customer/*.{aspx,Master}","./StayScape/StayScape/Host/*.{aspx,Master}"],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}

