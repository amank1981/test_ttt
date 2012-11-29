import com.damyant.Role
import com.damyant.User
import com.damyant.UserRole

class BootStrap {

    def init = { servletContext ->
            createRoles()
            createUsers()
    }
    def destroy = {
    }

         void createRoles() {

            if (!(Role.findByAuthority('ROLE_ADMIN'))) {
                new Role(authority: 'ROLE_ADMIN').save(flush: true)
            }

            if (!(Role.findByAuthority('ROLE_PLAYER'))) {
                new Role(authority: 'ROLE_PLAYER').save(flush: true)
            }

        }
         void createUsers() {
            Role role_admin = Role.findByAuthority('ROLE_ADMIN')
            if (!(User.findByUsername('user_admin'))) {
                User userAdmin
                userAdmin = new User(username: 'user_admin', password: 'damyant@123', name: 'Admin', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
                if (userAdmin.save()) {
                    UserRole.create userAdmin, role_admin
                    println "saved"
                }
                else {
                    println "errors are"
                    userAdmin.errors.allErrors.each {
                        println "Error --->> ${it}"
                    }
                }

            }

        }


}
