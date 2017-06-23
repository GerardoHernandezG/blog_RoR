module PermissionsConcern
	#para que sea un concern debe extender de este módulo
	extend ActiveSupport::Concern
	def is_normal_user?
		self.permission_level >= 1
	end

	def is_editor?
		self.permission_level >= 2
	end

	def is_admin?
		self.permission_level >= 3
	end
	#todos los métodos que retornan un boolean como true o false, van con el signo de interrogacion al final
end