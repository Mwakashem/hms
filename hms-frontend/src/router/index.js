import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'

// Lazy load components
const Login = () => import('../views/Login.vue')
const PatientDashboard = () => import('../views/PatientDashboard.vue')
const DoctorDashboard = () => import('../views/DoctorDashboard.vue')
const CreateAppointment = () => import('../views/CreateAppointment.vue')
const AppointmentDetails = () => import('../views/AppointmentDetails.vue')

const routes = [
  {
    path: '/',
    redirect: '/dashboard'
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
    meta: { requiresGuest: true }
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    beforeEnter: (to, from, next) => {
      const authStore = useAuthStore()
      if (authStore.isPatient) {
        next({ name: 'PatientDashboard' })
      } else if (authStore.isDoctor) {
        next({ name: 'DoctorDashboard' })
      } else {
        next({ name: 'Login' })
      }
    }
  },
  {
    path: '/patient',
    name: 'PatientDashboard',
    component: PatientDashboard,
    meta: { requiresAuth: true, role: 'patient' }
  },
  {
    path: '/doctor',
    name: 'DoctorDashboard',
    component: DoctorDashboard,
    meta: { requiresAuth: true, role: 'doctor' }
  },
  {
    path: '/appointments/create',
    name: 'CreateAppointment',
    component: CreateAppointment,
    meta: { requiresAuth: true, role: 'patient' }
  },
  {
    path: '/appointments/:id',
    name: 'AppointmentDetails',
    component: AppointmentDetails,
    meta: { requiresAuth: true }
  },
  {
    path: '/:pathMatch(.*)*',
    redirect: '/dashboard'
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// Navigation guards
router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()
  
  // Check if route requires authentication
  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    next({ name: 'Login' })
    return
  }
  
  // Check if route requires guest (not authenticated)
  if (to.meta.requiresGuest && authStore.isAuthenticated) {
    next({ name: 'Dashboard' })
    return
  }
  
  // Check role-based access
  if (to.meta.role && authStore.user?.role !== to.meta.role) {
    next({ name: 'Dashboard' })
    return
  }
  
  next()
})

export default router